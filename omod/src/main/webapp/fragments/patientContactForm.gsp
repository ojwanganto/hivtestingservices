<%
    ui.decorateWith("kenyaui", "panel", [heading: (command.original ? "Edit" : "Add") + " Contacts", frameOnly: true])

    def nameFields = [
            [
                    [object: command, property: "firstName", label: "First Name"],
                    [object: command, property: "middleName", label: "Middle Name"],
                    [object: command, property: "lastName", label: "Last Name"]
            ],
            ]
    def otherDemogFieldRows = [
            [
                    [object: command, property: "birthDate", label: "Date of Birth"]

            ]
    ]



    def addressRows = [
            [
                    [object: command, property: "physicalAddress", label: "Physical Address"],
                    [object: command, property: "phoneContact", label: "Phone No."]

            ]
            ]

    def relTypeOptions = [
            [
                    [ object: command, property: "relationType", label: "Relationship to patient", config: [ options: relationshipTypeOptions ] ]
            ]
    ]

    def hivData = [
            [

                    [object: command, property: "appointmentDate", label: "Appointment date"],
                    [object: command, property: "baselineHivStatus", label: "Baseline HIV status"],
                    [object: command, property: "ipvOutcome", label: "IPV Outcome"]

            ]
    ]

%>

<form id="edit-patient-contact-form" method="post" action="${ui.actionLink("hivtestingservices", "patientContactForm", "savePatientContact")}">
    <% if (command.original) { %>
    <input type="hidden" name="id" value="${command.original.id}"/>
    <% } %>

    <div class="ke-panel-content">

        <div class="ke-form-globalerrors" style="display: none"></div>

        <div class="ke-form-instructions">
            <strong>*</strong> indicates a required field
        </div>

    <fieldset>
            <legend>Demographics</legend>
        <input type="hidden" name="patientRelatedTo" value="${currentPatient.id}"/>
            <% nameFields.each { %>
            ${ui.includeFragment("kenyaui", "widget/rowOfFields", [fields: it])}
            <% } %>

            <table>
                <tr>
                    <td valign="top">
                        <label class="ke-field-label">Sex *</label>
                        <span class="ke-field-content">
                            <input type="radio" name="sex" value="F"
                                   id="gender-F" ${command.sex == 'F' ? 'checked="checked"' : ''}/> Female
                            <input type="radio" name="sex" value="M"
                                   id="gender-M" ${command.sex == 'M' ? 'checked="checked"' : ''}/> Male
                            <span id="gender-F-error" class="error" style="display: none"></span>
                            <span id="gender-M-error" class="error" style="display: none"></span>
                        </span>
                    </td>
                </tr>
            </table>

            <% otherDemogFieldRows.each { %>
            ${ui.includeFragment("kenyaui", "widget/rowOfFields", [fields: it])}
            <% } %>
        </fieldset>

    </fieldset>

        <fieldset>
            <legend>Address</legend>

            <% addressRows.each { %>
            ${ui.includeFragment("kenyaui", "widget/rowOfFields", [fields: it])}
            <% } %>

        </fieldset>

        <fieldset>
            <legend>Relationship</legend>
            <% relTypeOptions.each{ %>
            ${ui.includeFragment("kenyaui", "widget/rowOfFields", [fields: it])}
          <%  } %>

        </fieldset>
    <fieldset>
        <legend>hivData</legend>
        <% hivData.each { %>
        ${ui.includeFragment("kenyaui","widget/rowOfFields",[fields: it])}
        <%}%>
    </fieldset>

    </div>

    <div class="ke-panel-footer">
        <button type="submit">
            <img src="${ui.resourceLink("kenyaui", "images/glyphs/ok.png")}"/> ${command.original ? "Save Changes" : "Create Patient Contact"}
        </button>
        <% if (config.returnUrl) { %>
        <button type="button" class="cancel-button"><img
                src="${ui.resourceLink("kenyaui", "images/glyphs/cancel.png")}"/> Cancel</button>
        <% } %>
    </div>

</form>

<!-- You can't nest forms in HTML, so keep the dialog box form down here -->


<script type="text/javascript">
    //On ready
    jQuery(function () {

        //jQuery('#from-age-button').appendTo(jQuery('#from-age-button-placeholder'));
        jQuery('#edit-patient-contact-form .cancel-button').click(function () {
            ui.navigate('${ config.returnUrl }');
        });
        kenyaui.setupAjaxPost('edit-patient-contact-form', {
            onSuccess: function (data) {
                if (data.id) {
                    <% if (config.returnUrl) { %>
                    ui.navigate('${ config.returnUrl }');
                    <% } else { %>
                    ui.navigate('hivtestingservices', 'patientContactList', {patientId: data.id});
                    <% } %>
                } else {
                    kenyaui.notifyError('Saving patient contact was successful, but with unexpected response');
                }
            }
        });

    }); // end of jQuery initialization block


</script>