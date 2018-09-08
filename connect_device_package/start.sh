# stop script on error
set -e

# Check to see if root CA file exists, download if not
if [ ! -f ./root-CA.crt ]; then
  printf "\nDownloading AWS IoT Root CA certificate from Symantec...\n"
  curl https://www.symantec.com/content/en/us/enterprise/verisign/roots/VeriSign-Class%203-Public-Primary-Certification-Authority-G5.pem > root-CA.crt
fi

# install AWS Device SDK for NodeJS if not already installed
if [ ! -d ./node_modules ]; then
  printf "\nInstalling AWS SDK...\n"
  npm install aws-iot-device-sdk
fi

# run pub/sub sample app using certificates downloaded in package
printf "\nRunning pub/sub sample application...\n"
node node_modules/aws-iot-device-sdk/examples/device-example.js --host-name=afw2hjpsnzg18.iot.us-west-2.amazonaws.com --private-key=cc3220.private.key --client-certificate=cc3220.cert.pem --ca-certificate=root-CA.crt --client-id=sdk-nodejs-7ce89a0d-6e00-49b6-8523-ca4de81c5d8d