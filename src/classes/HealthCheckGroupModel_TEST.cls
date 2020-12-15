@isTest 
public with sharing class HealthCheckGroupModel_TEST {

    /*****************************************************************************************
    * @description Test to verify constructor with 7 parameters generates model as expected.
    *****************************************************************************************/
    @isTest 
    private static void constructorWithSevenParametersValid(){
        List<String> expandedRowsList = new List<String>{'aString', 'bString', 'cString'};
        List<HealthCheckItemVModel> healthCheckItemList = new List<HealthCheckItemVModel>();
        for (Integer i = 0; i<5; i++){
            HealthCheckItemVModel hlthChkItemVMod = new HealthCheckItemVModel('TestKey' + i, 
                                                                          'TestSetting' + i, 
                                                                          'TestStatus' + i, 
                                                                          'TestDescription' + i, 
                                                                          'TextRecommendedFix' + i);
            healthCheckItemList.add(hlthChkItemVMod);
        }

        Test.startTest();
        HealthCheckGroupModel hlthChkGroupMod = new HealthCheckGroupModel('TestLabel',
                                                                          'TestStatus', 
                                                                          'TestStatusLabel', 
                                                                          5, 
                                                                          8,
                                                                          expandedRowsList, 
                                                                          healthCheckItemList);
        Test.stopTest();

        System.assertEquals('TestLabel', hlthChkGroupMod.label, 'HealthCheckGroupModel label should be set to \'TestLabel\'..');
        System.assertEquals('TestStatus', hlthChkGroupMod.status, 'HealthCheckGroupModel status should be set to \'TestStatus\'.');
        System.assertEquals('TestStatusLabel', hlthChkGroupMod.statusLabel, 'HealthCheckGroupModel statusLabel should be set to \'TestStatusLabel\'.');
        System.assertEquals(5, hlthChkGroupMod.passedChecks, 'HealthCheckGroupModel passedChecks should be 5.');
        System.assertEquals(8, hlthChkGroupMod.totalChecks, 'HealthCheckGroupModel totalChecks should be 8.');
        System.assertEquals(3, hlthChkGroupMod.expandedRowsList.size(), 'HealthCheckGroupModel expandedRowsList should contain 3 strings.');
        System.assertEquals(5, hlthChkGroupMod.healthCheckItemList.size(), 'HealthCheckGroupModel healthCheckItemList should contain 5 healthCheckItem view models.');
    }

    /*****************************************************************************************
    * @description Test to verify compareTo() implementation separates HealthCheckGroupModels 
    * with 'Fail' status from those with 'Pass' status (Fail above Pass) and in ascending 
    * alphabetical order by label within each group when duplicates do not exist.
    *****************************************************************************************/
    @isTest
    private static void sortByStatusThenLabelWithoutDuplicates(){
        List<HealthCheckGroupModel> hlthChkGroupModelsList = new List<HealthCheckGroupModel>();


        HealthCheckGroupModel hlthChkGroupMod1 = new HealthCheckGroupModel('Zebra',
                                                                           'Fail', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());

        HealthCheckGroupModel hlthChkGroupMod2 = new HealthCheckGroupModel('zebra',
                                                                           'pass', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
        
        HealthCheckGroupModel hlthChkGroupMod3 = new HealthCheckGroupModel('Baboon',
                                                                           'Pass', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
       
        HealthCheckGroupModel hlthChkGroupMod4 = new HealthCheckGroupModel('Giraffe',
                                                                           'Fail', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
        
        HealthCheckGroupModel hlthChkGroupMod5 = new HealthCheckGroupModel('Lion',
                                                                           'Pass', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
        
        HealthCheckGroupModel hlthChkGroupMod6 = new HealthCheckGroupModel('Antelope',
                                                                           'Fail', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());

        hlthChkGroupModelsList.add(hlthChkGroupMod1);
        hlthChkGroupModelsList.add(hlthChkGroupMod2);
        hlthChkGroupModelsList.add(hlthChkGroupMod3);        
        hlthChkGroupModelsList.add(hlthChkGroupMod4);
        hlthChkGroupModelsList.add(hlthChkGroupMod5);
        hlthChkGroupModelsList.add(hlthChkGroupMod6);

        Test.startTest();
        hlthChkGroupModelsList.sort();
        Test.stopTest();

        System.assertEquals(true, hlthChkGroupModelsList[0].label.equalsIgnoreCase('Antelope'));
        System.assertEquals(true, hlthChkGroupModelsList[0].status.equalsIgnoreCase('Fail'));
        System.assertEquals(true, hlthChkGroupModelsList[1].label.equalsIgnoreCase('Giraffe'));
        System.assertEquals(true, hlthChkGroupModelsList[1].status.equalsIgnoreCase('Fail'));
        System.assertEquals(true, hlthChkGroupModelsList[2].label.equalsIgnoreCase('Zebra'));
        System.assertEquals(true, hlthChkGroupModelsList[2].status.equalsIgnoreCase('Fail'));
        System.assertEquals(true, hlthChkGroupModelsList[3].label.equalsIgnoreCase('Baboon'));
        System.assertEquals(true, hlthChkGroupModelsList[3].status.equalsIgnoreCase('Pass'));
        System.assertEquals(true, hlthChkGroupModelsList[4].label.equalsIgnoreCase('Lion'));
        System.assertEquals(true, hlthChkGroupModelsList[4].status.equalsIgnoreCase('Pass'));
        System.assertEquals(true, hlthChkGroupModelsList[5].label.equalsIgnoreCase('Zebra'));
        System.assertEquals(true, hlthChkGroupModelsList[5].status.equalsIgnoreCase('Pass'));
    }

    /*****************************************************************************************
    * @description Test to verify compareTo() implementation separates HealthCheckGroupModels 
    * with 'Fail' status from those with 'Pass' status (Fail above Pass) and in ascending 
    * alphabetical order by label within each group when duplicates exist.
    *****************************************************************************************/
    @isTest
    private static void sortByStatusThenLabelWithDuplicates(){
        List<HealthCheckGroupModel> hlthChkGroupModelsList = new List<HealthCheckGroupModel>();


        HealthCheckGroupModel hlthChkGroupMod1 = new HealthCheckGroupModel('Zebra',
                                                                           'Pass', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());

        HealthCheckGroupModel hlthChkGroupMod2 = new HealthCheckGroupModel('zebra',
                                                                           'pass', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
        
        HealthCheckGroupModel hlthChkGroupMod3 = new HealthCheckGroupModel('Meerkat',
                                                                           'Fail', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
       
        HealthCheckGroupModel hlthChkGroupMod4 = new HealthCheckGroupModel('lion',
                                                                           'fail', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
        
        HealthCheckGroupModel hlthChkGroupMod5 = new HealthCheckGroupModel('Lion',
                                                                           'fail', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());
        
        HealthCheckGroupModel hlthChkGroupMod6 = new HealthCheckGroupModel('Antelope',
                                                                           'Pass', 
                                                                           'TestStatusLabel', 
                                                                           5, 
                                                                           8,
                                                                           new List<String>(), 
                                                                           new List<HealthCheckItemVModel>());

        hlthChkGroupModelsList.add(hlthChkGroupMod1);
        hlthChkGroupModelsList.add(hlthChkGroupMod2);
        hlthChkGroupModelsList.add(hlthChkGroupMod3);        
        hlthChkGroupModelsList.add(hlthChkGroupMod4);
        hlthChkGroupModelsList.add(hlthChkGroupMod5);
        hlthChkGroupModelsList.add(hlthChkGroupMod6);

        Test.startTest();
        hlthChkGroupModelsList.sort();
        Test.stopTest();

        System.assertEquals(true, hlthChkGroupModelsList[0].label.equalsIgnoreCase('Lion'));
        System.assertEquals(true, hlthChkGroupModelsList[0].status.equalsIgnoreCase('Fail'));
        System.assertEquals(true, hlthChkGroupModelsList[1].label.equalsIgnoreCase('Lion'));
        System.assertEquals(true, hlthChkGroupModelsList[1].status.equalsIgnoreCase('Fail'));
        System.assertEquals(true, hlthChkGroupModelsList[2].label.equalsIgnoreCase('Meerkat'));
        System.assertEquals(true, hlthChkGroupModelsList[2].status.equalsIgnoreCase('Fail'));
        System.assertEquals(true, hlthChkGroupModelsList[3].label.equalsIgnoreCase('Antelope'));
        System.assertEquals(true, hlthChkGroupModelsList[3].status.equalsIgnoreCase('Pass'));
        System.assertEquals(true, hlthChkGroupModelsList[4].label.equalsIgnoreCase('Zebra'));
        System.assertEquals(true, hlthChkGroupModelsList[4].status.equalsIgnoreCase('Pass'));
        System.assertEquals(true, hlthChkGroupModelsList[5].label.equalsIgnoreCase('Zebra'));
        System.assertEquals(true, hlthChkGroupModelsList[5].status.equalsIgnoreCase('Pass'));
    }
}