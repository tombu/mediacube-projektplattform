Category.create([
  {:label=>'Kunst'},
  {:label=>'Fotografie'},
  {:label=>'Film'},
  {:label=>'Animation'},
  {:label=>'Werbung'},
  {:label=>'Design'},
  {:label=>'Game'},
  {:label=>'Flash'},
  {:label=>'Web'},
  {:label=>'Community'},
  {:label=>'Audio'},
  {:label=>'Mobile'},
  {:label=>'Typografie'},
  {:label=>'Motion Graphics'},
  {:label=>'Sozial'}
])

Texttemplates.create([
  {:key=>'media_new',:text=>'#user hat neue Medien hochgeladen.'},
  {:key=>'project_edit',:text=>'Das Projekt wurde editiert.'},
  {:key=>'project_status_edit',:text=>'Der <b>Projektstatus</b> wurde auf <span>#status</span> gesetzt.'},
  {:key=>'project_current_stage_edit',:text=>'Das Projekt befindet sich jetzt in der Stage <span>#stage</span>.'},
  {:key=>'job_new',:text=>'Es wurden neue Jobs ausgeschrieben:<br /><span>#jobs</span>'},
  {:key=>'job_delete',:text=>'Folgende Jobs sind nicht mehr verfügbar:<br /><span>#jobs</span>'},
  {:key=>'team_new',:text=>'ist ein neues Teammitglied.'},
  {:key=>'team_delete',:text=>'hat das Team verlassen.'}
])