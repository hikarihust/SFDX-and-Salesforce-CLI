/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public with sharing class TreeLocationControllerTest {

    @TestSetup
    static void makeData(){
        Tree__c tree = new Tree__c(Name='Banyan Tree', Benefit__c='Dummy Benefits Here', Picture__c='');
        insert tree;
        City__c city = new City__c(Name='Jaipur', Location__Latitude__s=26.912434, Location__Longitude__s=75.78727);
        insert city;
        Tree_Plantation__c treePlantation = new Tree_Plantation__c(Planted_In__c=city.Id, Tree__c=tree.Id);
        insert treePlantation;
    }

    @isTest
    static void testGetTreeLocations(){
        Test.startTest();
        List<Tree__c> trees = [SELECT Id, Name FROM Tree__C];
        List<Tree_Plantation__c> treePlantation = TreeLocationController.getTreeLocations(trees[0].Id);
        Test.stopTest();

        System.assert(trees.size() == 1, 'More or less tree found');
        System.assertEquals('Banyan Tree', trees[0].Name, 'Tree name did not match');
        System.assert(treePlantation.size() == 1, 'More or less treePlantation records found');
        System.assertEquals('Jaipur', treePlantation[0].Planted_In__r.Name, 'City name did not match');   
    }
}