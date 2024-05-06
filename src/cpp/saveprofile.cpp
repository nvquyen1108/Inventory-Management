#include "../include/saveprofile.h"
#include "../include/serverconnect.h"

saveprofile::saveprofile()
{
    QSqlDatabase::removeDatabase("qt_sql_default_connection");
    m_db = QSqlDatabase::addDatabase("QPSQL");
    m_db.setHostName("localhost");
    m_db.setPort(5432);
    m_db.setDatabaseName("anhquyen");
    m_db.setUserName("postgres");
    m_db.setPassword("minhanhas");

    if (m_db.open()) {
        qDebug() << "sucsses to connect to database:";
    }else{
        qDebug() << "fail to connect to database:";
        qDebug() << m_db.lastError().text();
    }
    m_db.close();
}

void saveprofile::save_data_personal(QString employee_code, QString fullname, QString sex, QString date_of_birth, QString military_service, QString academic_level, QString major, QString the_name_of_manager, QString employee_code_of_manager, QString tax_code, QString timekeeping_location, QString phone_number, QString email_address, QString accommodation_address)
{
    QSqlQuery query(m_db);
    query.prepare("INSERT INTO personal (employee_code,fullname,sex,date_of_birth,military_service,academic_level,major,the_name_of_manager,employee_code_of_manager,tax_code,timekeeping_location,phone_number,email_address,accommodation_address) VALUES (:employee_code,:fullname,:sex,:date_of_birth,:military_service,:academic_level,:major,:the_name_of_manager,:employee_code_of_manager,:tax_code,:timekeeping_location,:phone_number,:email_address,:accommodation_address)");
    query.bindValue(":employee_code", employee_code);
    query.bindValue(":fullname", fullname);
    query.bindValue(":sex", sex);
    query.bindValue(":date_of_birth", date_of_birth);
    query.bindValue(":military_service", military_service);
    query.bindValue(":academic_level", academic_level);
    query.bindValue(":major", major);
    query.bindValue(":the_name_of_manager", the_name_of_manager);
    query.bindValue(":employee_code_of_manager", employee_code_of_manager);
    query.bindValue(":tax_code", tax_code);
    query.bindValue(":timekeeping_location", timekeeping_location);
    query.bindValue(":phone_number", phone_number);
    query.bindValue(":email_address", email_address);
    query.bindValue(":accommodation_address", accommodation_address);
    query.exec();
}
void saveprofile:: save_data_profile(QString profile_code, QString type_of_labor_contact, QString date_of_joinning_the_company, QString date_of_signing_the_labor_contract, QString employee_code)
{
    QSqlQuery query(m_db);
    query.prepare("INSERT INTO profile (profile_code,type_of_labor_contact,date_of_joinning_the_company,date_of_signing_the_labor_contract,employee_code) VALUES (:profile_code,:type_of_labor_contact,:date_of_joinning_the_company,:date_of_signing_the_labor_contract,:employee_code)");
    query.bindValue(":employee_code", employee_code);
    query.exec();
}
//void saveprofile:: save_data_citizen_identify_card(QString citizen_identify_card_number, QString place_of_origin, QString place_of_residence, QString date_of_release, QString date_of_expiry, QString religion, QString nationality, QString merial_status, QString employee_code)
//{

//}
//void saveprofile:: save_data_images_citizen_identify_card(QString the_front_of_citizen_identify_card, QString the_back_of_identify_card, QString employee_code)
//{

//}
//void saveprofile:: save_data_bank(QString bank_account_number, QString bank_account_name, QString bank_name, QString bank_branch, QString employee_code)
//{

//}
//void saveprofile:: save_data_study_process(QString form_day, QString to_day, QString form_training, QString academic_level, QString training_place, QString major, QString fullname)
//{

//}
//void saveprofile:: save_data_family_infomation(QString citizen_identify_card_number, QString full_name, QString relationship, QString date_of_birth, QString phone_number, QString date_of_release, QString date_of_expiry, QString dependent_state, QString form_day, QString to_day, QString tax_code, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_work_experience(QString form_month, QString to_month, QString company_name, QString job_position, QString job_description, QString employee_code)
//{

//}
//void saveprofile:: save_data_avatar(QString url_avatar, QString employee_code)
//{

//}
//void saveprofile:: save_data_note(QString note_text, QString employee_code)
//{

//}
//void saveprofile:: save_data_labor_contract(QString profile_code, QString type_of_labor_contact, QString department, QString teams, QString job_position, QString work_place, QString form_of_work, QString effect_form_day, QString to_day, QString contract_signing_date, QString date_of_expiry, QString person_signing_contact, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_salary_allwances(QString form_day, QString note, QString salary_form, QString salary_amount, QString allowances_form, QString allowances_amount, QString employee_code)
//{

//}
//void saveprofile:: save_data_insurance_infomation(QString insurance_book_id_number, QString type_of_insurance, QString insurance_book_status, QString legal_insurance_paying_entify, QString issued_by, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_insurance_payment_history(QString type_of_insurance, QString form_month, QString form, QString reason, QString legal_insurance_paying_entity, QString insurance_payment_rate, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_health(QString height, QString weight, QString blood_pressure, QString blood_type, QString heartbeat, QString pre_existing_disease, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_degrees(QString academic_level, QString training_place, QString form_of_training, QString time_of_training, QString form_month, QString to_month, QString major, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_certificate(QString certificate_name, QString training_place, QString form_of_training, QString time_of_training, QString form_month, QString to_month, QString major, QString note, QString employee_code)
//{

//}
//void saveprofile:: save_data_title_reward(QString title_reward_name, QString issued_by, QString major, QString date_of_release, QString note, QString employee_code)
//{

//}
