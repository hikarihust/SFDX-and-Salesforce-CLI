# Set env/temp variable
printf "STEP 1: Setting up temp variable\n"
export DEV_HUB_USER_NAME=vudinhquangk53+sfdx@gmail.com
export COSUMER_KEY=3MVG9n_HvETGhr3DlkICjPm6sn8V8Lg.AWv4h_AvjTVCxQ1F.2fckZz4KKi49pfNUW2KEzvV8GP2eVkLe06_Q
export SERVER_KEY_LOCATION="/c/xampp/htdocs/SFDX-and-Salesforce-CLI/assets/server.key"
export SFDX_PROJECT_LOCATION="/c/xampp/htdocs/SFDX-and-Salesforce-CLI/CLI-Automation"


printf "STEP 2: Moving in project folder $SFDX_PROJECT_LOCATION\n"
cd "$SFDX_PROJECT_LOCATION"

printf "STEP 3: Creating new directory $(date +'%Y%m%d')\n"
mkdir $(date +'%Y%m%d')
cd $(date +'%Y%m%d')

# cloning github repo
printf "STEP 4: Cloning github repo\n"
git clone https://github.com/vudinhquang/tree-plantation.git
cd tree-plantation
    
# authorize dev hub org
printf "STEP 5: Authorizing Dev Hub Org\n"
sfdx force:auth:jwt:grant --clientid $COSUMER_KEY --jwtkeyfile  "$SERVER_KEY_LOCATION" --username $DEV_HUB_USER_NAME --setdefaultdevhubusername --setalias CLISessionDevHub

# creating scratch org
printf "STEP 6: Creating scratch org\n"
sfdx force:org:create  --setdefaultusername --definitionfile config/project-scratch-def.json --setalias $(date +'%Y%m%d') --wait 10 --durationdays 30

# pushing metadata to scracth org
printf "STEP 7: Pushing metadata to scratch org"
sfdx force:source:push

# assign permission set
printf "STEP 8: Assigning permission set"
sfdx force:user:permset:assign -n TreePlantation

# upload sample data to scratch org
printf "STEP 9: Uploading sample data"
sfdx force:data:tree:import --plan sample-data/import-plan.json

# opening scratch org
printf "STEP 10: Opening scratch org"
sfdx force:org:open