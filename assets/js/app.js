(()=>{'use strict';
const root=document.documentElement;
const store={get(k){try{return localStorage.getItem(k)}catch{return null}},set(k,v){try{localStorage.setItem(k,v)}catch{}}};
const saved=store.get('ems-theme');if(saved==='light'||saved==='dark')root.dataset.theme=saved;
document.querySelectorAll('.theme-toggle').forEach(btn=>btn.addEventListener('click',()=>{const next=root.dataset.theme==='dark'?'light':'dark';root.dataset.theme=next;store.set('ems-theme',next)}));

// Mobile menu
const side=document.getElementById('sidebar'),scrim=document.getElementById('sidebarScrim'),menuBtn=document.getElementById('menuToggle');
const setMenu=open=>{side?.classList.toggle('open',open);scrim?.classList.toggle('open',open);menuBtn?.setAttribute('aria-expanded',open?'true':'false');menuBtn?.setAttribute('aria-label',open?'Close menu':'Open menu')};
menuBtn?.addEventListener('click',()=>setMenu(!side?.classList.contains('open')));
scrim?.addEventListener('click',()=>setMenu(false));
side?.querySelectorAll('a').forEach(a=>a.addEventListener('click',()=>setMenu(false)));
window.addEventListener('resize',()=>{if(window.innerWidth>780)setMenu(false)});

document.querySelectorAll('[data-password]').forEach(btn=>btn.addEventListener('click',()=>{const el=document.getElementById(btn.dataset.password);if(el){el.type=el.type==='password'?'text':'password';btn.textContent=el.type==='password'?'Show':'Hide'}}));

// Modals
const modalDefaults=new Map();
document.querySelectorAll('.modal-backdrop').forEach(modal=>{const h=modal.querySelector('h2');const submit=modal.querySelector('form .form-actions .primary');modalDefaults.set(modal,{title:h?.textContent||'',submit:submit?.textContent||''})});
const setModalMode=(modal,editing,title,submitLabel)=>{const h=modal.querySelector('h2');const submit=modal.querySelector('form .form-actions .primary');const d=modalDefaults.get(modal)||{};if(h)h.textContent=editing?title:d.title;if(submit)submit.textContent=editing?submitLabel:d.submit};
document.querySelectorAll('[data-modal-open]').forEach(btn=>btn.addEventListener('click',()=>{const modal=document.getElementById(btn.dataset.modalOpen);if(!modal)return;const form=modal.querySelector('form');const idField=form?.querySelector('[name=id]');if(form&&idField){form.reset();idField.value='';modal.querySelectorAll('select option').forEach(o=>{o.hidden=false});setModalMode(modal,false)}modal.classList.add('open');modal.querySelector('input:not([type=hidden]),select,textarea')?.focus()}));
const closeModal=modal=>modal?.classList.remove('open');
document.querySelectorAll('[data-modal-close]').forEach(btn=>btn.addEventListener('click',()=>closeModal(btn.closest('.modal-backdrop'))));
document.querySelectorAll('.modal-backdrop').forEach(modal=>modal.addEventListener('click',e=>{if(e.target===modal)closeModal(modal)}));
document.addEventListener('keydown',e=>{if(e.key==='Escape'){document.querySelectorAll('.modal-backdrop.open').forEach(closeModal);setMenu(false)}});

document.querySelectorAll('[data-edit-department]').forEach(btn=>btn.addEventListener('click',()=>{const d=JSON.parse(btn.dataset.editDepartment);const modal=document.getElementById('department-modal');if(!modal)return;setModalMode(modal,true,'Edit department','Save changes');modal.querySelector('[name=id]').value=d.id;modal.querySelector('[name=department_name]').value=d.department_name;modal.querySelector('[name=department_code]').value=d.department_code;modal.querySelector('[name=description]').value=d.description||'';modal.querySelector('[name=status]').value=d.status;modal.classList.add('open')}));
document.querySelectorAll('[data-edit-employee]').forEach(btn=>btn.addEventListener('click',()=>{const e=JSON.parse(btn.dataset.editEmployee);const modal=document.getElementById('employee-modal');if(!modal)return;setModalMode(modal,true,'Edit employee','Save changes');for(const key of ['id','first_name','last_name','email','phone','department_id','manager_id','designation','salary_amount','joining_date','employment_status']){const input=modal.querySelector(`[name="${key}"]`);if(input)input.value=e[key]??''}modal.classList.add('open')}));
document.querySelectorAll('#user-modal [name=username]').forEach(input=>input.addEventListener('input',()=>{const email=document.querySelector('#user-modal [name=email]');if(email)email.value=input.value+'@ems.com'}));
document.querySelectorAll('#employee-modal [name=first_name],#employee-modal [name=last_name]').forEach(input=>input.addEventListener('input',()=>{const modal=input.closest('#employee-modal');if(modal&&!modal.querySelector('[name=id]').value){const clean=x=>x.trim().toLowerCase().replace(/[^a-z0-9]+/g,'.').replace(/^\.|\.$/g,'');const f=clean(modal.querySelector('[name=first_name]').value),l=clean(modal.querySelector('[name=last_name]').value);modal.querySelector('[name=email]').value=(f&&l?f+'.'+l:'')+'@ems.com'}}));
document.querySelectorAll('#employee-modal [name=department_id]').forEach(select=>select.addEventListener('change',()=>{const manager=document.querySelector('#employee-modal [name=manager_id]');if(manager){Array.from(manager.options).forEach(option=>{option.hidden=!!(option.value&&select.value&&option.dataset.global!=='1'&&option.dataset.department!==select.value)});manager.value=''}}));
document.querySelectorAll('[data-edit-leave]').forEach(btn=>btn.addEventListener('click',()=>{const item=JSON.parse(btn.dataset.editLeave);const modal=document.getElementById('leave-edit-modal');if(!modal)return;for(const key of ['id','leave_type','status','start_date','end_date','reason']){const field=modal.querySelector(`[name="${key}"]`);if(field)field.value=item[key]??''}modal.classList.add('open')}));

// Messages and submit state
document.querySelectorAll('[data-flash] .flash-close').forEach(btn=>btn.addEventListener('click',()=>btn.closest('.flash')?.remove()));
document.querySelectorAll('form[data-loading]').forEach(form=>form.addEventListener('submit',()=>{const b=form.querySelector('button[type=submit]');if(b){b.disabled=true;b.setAttribute('aria-busy','true');b.textContent='Signing in'}}));
})();
