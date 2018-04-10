/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 * <p>
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 * <p>
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
package org.openmrs.module.hivtestingservices.api.db.hibernate;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.hivtestingservices.api.db.HTSDAO;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Query;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.hibernate.SessionFactory;
import org.openmrs.module.hivtestingservices.api.PatientContact;


public class HibernateHTSDAO implements HTSDAO {
    protected final Log log = LogFactory.getLog(this.getClass());

    private SessionFactory sessionFactory;
    /**
     * @Autowired private HTSDAO htsDAO;
     */

    /**
     * @param sessionFactory the sessionFactory to set
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /**
     * @return the sessionFactory
     */

    @Override
    public PatientContact savePatientContact(PatientContact patientContact) throws DAOException {

        sessionFactory.getCurrentSession().saveOrUpdate(patientContact);
        return patientContact;

    }

    @Override
    public List<PatientContact> getPatientContacts() {
        Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PatientContact.class);
        criteria.add(Restrictions.eq("voided", false));
        //return result
        return criteria.list();
    }

    @Override
    public void voidPatientContact(int theId) {

        Criteria criteria = this.sessionFactory.getCurrentSession().createCriteria(PatientContact.class);
        //CriteriaBuilder criteriaBuilder = this.entityManager.getCriteriaBuilder();

        //sessionFactory.getCurrentSession().createQuery("update PatientContact set voided = 'true' where id=:theId").executeUpdate();
        //getSessionFactory().getCurrentSession().createQuery(query).executeUpdate();
    }

    @Override
    public List<PatientContact> searchPatientContact(String searchName) {
        // get the current hibernate session

        Query query = null;
        //only search by name if name is not empty
        if (searchName != null && searchName.trim().length() > 0) {

            //query = this.sessionFactory.getCurrentSession().createQuery("FROM PatientContact where lower(firstName) like :searchName or lower(lastName) like :searchName or lower(middleName) like :searchName");
            //query.setParameter("searchName","%"+searchName.toLowerCase()+"%");

        } else {
            //the searchName is empty...so list patient contacts
            //query = this.sessionFactory.getCurrentSession().createQuery("FROM PatientContact");
        }
        //Execute query and get the result list
        List<PatientContact> contacts = query.list();
        return contacts;
    }

    @Override
    public PatientContact getPatientContactByID(Integer patientContactId) {
        return (PatientContact) this.sessionFactory.getCurrentSession().get(PatientContact.class, patientContactId);
    }


}