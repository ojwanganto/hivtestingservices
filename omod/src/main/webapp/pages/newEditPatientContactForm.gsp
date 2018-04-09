<%
    ui.decorateWith("kenyaemr", "standardPage")
%>
<div class="ke-page-content">
    ${ ui.includeFragment("hivtestingservices", "patientContactForm", [ patientId: currentPatient.id ]) }
</div>