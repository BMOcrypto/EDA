@isTest 
public with sharing class HealthCheckItemVModel_TEST {

    /*****************************************************************************************
    * @description Test to verify constructor with 5 parameters generates model as expected.
    *****************************************************************************************/
    @isTest 
    private static void constructorWithFiveParamsValid(){
        Test.startTest();
        HealthCheckItemVModel hlthChkItemVMod = new HealthCheckItemVModel('TestKey', 
                                                                          'TestSetting', 
                                                                          'TestStatus', 
                                                                          'TestDescription', 
                                                                          'TextRecommendedFix');
        Test.stopTest();

        System.assertEquals('TestKey', hlthChkItemVMod.key, 'HealthCheckItemVModel key should be set to \'TestKey\'');
        System.assertEquals('TestSetting', hlthChkItemVMod.setting, 'HealthCheckItemVModel key should be set to \'TestSetting\'');
        System.assertEquals('TestStatus', hlthChkItemVMod.status, 'HealthCheckItemVModel key should be set to \'TestStatus\'');
        System.assertEquals('TestStatus', hlthChkItemVMod.description, 'HealthCheckItemVModel key should be set to \'TestStatus\'');
        System.assertEquals('TextRecommendedFix', hlthChkItemVMod.recommendedFix, 'HealthCheckItemVModel key should be set to \'TextRecommendedFix\'');
    }

    /*****************************************************************************************
    * @description Test to verify that compareTo() sorts by....
    *****************************************************************************************/
    private static void sortValid(){
        List<HealthCheckItemVModel> hlthChkItemVModelsList = new List<HealthCheckItemVModel>();

        Test.startTest();
        hlthChkItemVModelsList.sort();
        Test.stopTest();
    }
}