<?php
function payroll_amount(mixed $value): float {
    $raw=trim((string)$value);if($raw==='')return 0.0;if(!is_numeric($raw)||!is_finite((float)$raw)||(float)$raw<0||(float)$raw>100000000)throw new RuntimeException('Enter a valid non-negative amount.');return round((float)$raw,2);
}

function payroll_calculation(array $s,float $otherEarnings,float $otherDeductions,float $salaryFactor=1.0): array {
    $salaryFactor=max(0,min(1,$salaryFactor));$monthly=['basic'=>(float)$s['basic_salary'],'da'=>(float)$s['dearness_allowance'],'hra'=>(float)$s['hra'],'allowances'=>(float)$s['other_allowances']];$targetGross=round(array_sum($monthly)*$salaryFactor,2);$lastActive=null;foreach($monthly as $key=>$amount)if($amount>0)$lastActive=$key;$parts=[];$running=0.0;foreach($monthly as $key=>$amount){$parts[$key]=$key===$lastActive?round($targetGross-$running,2):round($amount*$salaryFactor,2);$running+=$parts[$key];}$basic=$parts['basic'];$da=$parts['da'];$hra=$parts['hra'];$allow=$parts['allowances'];
    $gross=round($basic+$da+$hra+$allow+$otherEarnings,2);
    // Apply the 50% allowance add-back rule; employer PF is part of total remuneration.
    $excluded=max(0,$hra+$allow+$otherEarnings);$included=$basic+$da;$rate=(float)($s['epf_rate']??12);$employerPf=0;$pfWage=0;
    if(!empty($s['epf_covered'])){for($i=0;$i<16;$i++){$pfWage=min(25000,max(0,$included+max(0,$excluded-(($gross+$employerPf)*0.5))));$next=round($pfWage*$rate/100);if($next===$employerPf)break;$employerPf=$next;}}
    $employeePf=round($pfWage*$rate/100);$employerPf=round($pfWage*$rate/100);
    $pt=(!empty($s['pt_exempt'])||$gross<=12000)?0:200;
    $total=round($employeePf+$pt+$otherDeductions,2);$net=round($gross-$total,2);
    if($net<0)throw new RuntimeException('Total deductions cannot exceed gross earnings. Reduce the manual deductions.');
    return ['basic'=>$basic,'da'=>$da,'hra'=>$hra,'allowances'=>$allow,'other_earnings'=>$otherEarnings,'gross'=>$gross,'pf_wage'=>$pfWage,'employee_pf'=>$employeePf,'employer_pf'=>$employerPf,'professional_tax'=>$pt,'other_deductions'=>$otherDeductions,'total_deductions'=>$total,'net'=>$net,'salary_factor'=>$salaryFactor];
}

function payroll_default_pay_date(PDO $pdo,string $period): string {
    $first=DateTimeImmutable::createFromFormat('!Y-m-d',$period.'-01');if(!$first)throw new RuntimeException('Choose a valid salary month.');$next=$first->modify('first day of next month');return $next->setDate((int)$next->format('Y'),(int)$next->format('m'),7)->format('Y-m-d');
}

function issue_payslip(PDO $pdo,int $employee,string $period,string $payDate,float $earnings,float $deductions,int $issuer): array {
    if(!preg_match('/^\d{4}-(0[1-9]|1[0-2])$/D',$period)||!preg_match('/^\d{4}-\d{2}-\d{2}$/D',$payDate))throw new RuntimeException('Choose a valid salary month and payment date.');
    $date=DateTimeImmutable::createFromFormat('!Y-m-d',$payDate);if(!$date||$date->format('Y-m-d')!==$payDate)throw new RuntimeException('Choose a valid payment date.');
    if($payDate!==payroll_default_pay_date($pdo,$period))throw new RuntimeException('Payroll payday is the 7th of the month after the salary month.');
    $q=$pdo->prepare('SELECT e.employee_id,e.joining_date,s.* FROM employees e JOIN salary_structures s ON s.employee_id=e.id WHERE e.id=? AND e.employment_status=\'active\'');$q->execute([$employee]);$s=$q->fetch();if(!$s)throw new RuntimeException('Save a salary structure for an active employee first.');
    $monthStart=$period.'-01';$monthEnd=(new DateTimeImmutable($monthStart))->modify('last day of this month')->format('Y-m-d');if($s['joining_date']>$monthEnd)throw new RuntimeException('This employee had not joined during the selected salary month.');$scheduledDays=ems_leave_workdays($pdo,$monthStart,$monthEnd);if($scheduledDays<1)throw new RuntimeException('No scheduled working days are configured for this salary month.');$payableDays=$s['joining_date']>$monthStart?ems_leave_workdays($pdo,$s['joining_date'],$monthEnd):$scheduledDays;if($payableDays<1)throw new RuntimeException('There are no payable workdays after the employee’s joining date in this month.');$salaryFactor=$payableDays/$scheduledDays;
    $c=payroll_calculation($s,$earnings,$deductions,$salaryFactor);$rate=(float)$s['epf_rate'];
    $sql='INSERT INTO payslips(employee_id,period,pay_date,basic_salary,dearness_allowance,hra,other_allowances,other_earnings,gross_salary,pf_wage,epf_rate,employee_pf,employer_pf,professional_tax,other_deductions,total_deductions,net_salary,scheduled_days,payable_days,issued_by) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE pay_date=VALUES(pay_date),basic_salary=VALUES(basic_salary),dearness_allowance=VALUES(dearness_allowance),hra=VALUES(hra),other_allowances=VALUES(other_allowances),other_earnings=VALUES(other_earnings),gross_salary=VALUES(gross_salary),pf_wage=VALUES(pf_wage),epf_rate=VALUES(epf_rate),employee_pf=VALUES(employee_pf),employer_pf=VALUES(employer_pf),professional_tax=VALUES(professional_tax),other_deductions=VALUES(other_deductions),total_deductions=VALUES(total_deductions),net_salary=VALUES(net_salary),scheduled_days=VALUES(scheduled_days),payable_days=VALUES(payable_days),issued_by=VALUES(issued_by),issued_at=CURRENT_TIMESTAMP';
    $pdo->prepare($sql)->execute([$employee,$period,$payDate,$c['basic'],$c['da'],$c['hra'],$c['allowances'],$c['other_earnings'],$c['gross'],$c['pf_wage'],$rate,$c['employee_pf'],$c['employer_pf'],$c['professional_tax'],$c['other_deductions'],$c['total_deductions'],$c['net'],$scheduledDays,$payableDays,$issuer]);
    return ['employee_id'=>$s['employee_id'],'scheduled_days'=>$scheduledDays,'payable_days'=>$payableDays,'gross'=>$c['gross']];
}
