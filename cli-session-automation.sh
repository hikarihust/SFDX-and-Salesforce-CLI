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
    