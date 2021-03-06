/*
    Copyright (c) 2019, Salesforce.org
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Salesforce.org nor the names of
      its contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
    FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
    COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
    INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
    BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
    LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
*/
/**
* @author Salesforce.org
* @date 2019
* @group Course Enrollments
* @group-content ../../ApexDocContent/CourseEnrollments.htm
* @description When a Term Grade or an Attendance Event is present on a Course Connection, 
* this class prevents changes to a Contact or Course Offering on that Course Connection.
*/
public with sharing class CCON_PreventUpdate_TDTM extends TDTM_Runnable {
   
    /*******************************************************************************************************
    * @description When a Term Grade or an Attendance Event is present on a Course Connection,
    * this class prevents changes to a Contact or Course Offering fields on the record.
    * @param listNew the list of Course Connections from trigger new.
    * @param listOld the list of Course Connections from trigger old.
    * @param triggerAction which trigger event (BeforeUpdate).
    * @param objResult the describe for Course Connections.
    * @return dmlWrapper
    ********************************************************************************************************/
    public override DmlWrapper run(List<SObject> newlist, List<SObject> oldlist,
    TDTM_Runnable.Action triggerAction, Schema.DescribeSObjectResult objResult) {
    
        Map<Id, Course_Enrollment__c> newMap = new Map<Id, Course_Enrollment__c>((List<Course_Enrollment__c>)newList);
        
        if (triggerAction == TDTM_Runnable.Action.BeforeUpdate) { 
            for (Course_Enrollment__c courseEnrollment: [SELECT Id, Contact__c, Course_Offering__c, (SELECT Id FROM Term_Grades__r LIMIT 1), (SELECT Id FROM Attendance_Events__r LIMIT 1) FROM Course_Enrollment__c WHERE Id IN :newlist]) {
      
                Boolean contactChanged = (courseEnrollment.Contact__c != (newMap.get(courseEnrollment.Id)).Contact__c);
                Boolean courseOfferingChanged = (courseEnrollment.Course_Offering__c != (newMap.get(courseEnrollment.Id)).Course_Offering__c);

                Boolean hasTermGradesOrAttendanceEvents = (courseEnrollment.Term_Grades__r.size() > 0 || courseEnrollment.Attendance_Events__r.size() > 0);
                
                // Prevent changes to Course Offering or Contact look ups if there are Term Grades or Attendance Events associated with the Course Connection

                if ((contactChanged || courseOfferingChanged) && hasTermGradesOrAttendanceEvents) {                   
                    Course_Enrollment__c courseEnrollmentInContext = newMap.get(courseEnrollment.Id);
                    courseEnrollmentInContext.addError(Label.CannotChangeContactAndCourseOffering);                
               }           
            }
        }        
        return new DmlWrapper();       
    }
    
}