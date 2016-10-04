# Fabric SharePoint Add-in Template

Provider-hosted SharePoint add-in template using [Office UI Fabric](https://github.com/OfficeDev/Office-UI-Fabric) styles. You can use this sample template as a starter project to build your SharePoint add-ins with Fabric styles. The project uses both Office UI Fabric styles and components, namely the NavBar and Button components.

![SharePoint add-in using Office UI Fabric](http://chakkaradeep.com/wp-content/uploads/2015/09/fabric-spaddin.png)

## How to Run this Sample

To run this sample, you need:

1. [Visual Studio 2015](https://www.visualstudio.com/en-us/downloads/download-visual-studio-vs.aspx)
2. [Office 365 Developer Subscription](https://portal.office.com/Signup/Signup.aspx?OfferId=6881A1CB-F4EB-4db3-9F18-388898DAF510&DL=DEVELOPERPACK&ali=1)

### Step 1: Clone or download this repository

From your Git Shell or command line:

`git clone https://github.com/OfficeDev/FabricSharePointAddin-Template.git`

### Step 2: Build the Project

1. Open the project in Visual Studio 2015
2. Simply Build the project to restore NuGet packages
3. In the Solution Explorer, click on FabricSharePointAddin.SharePoint project
4. In the Properties Window, scroll to reveal the Site URL property and enter your SharePoint developer site URL

### Step 3: Build and Debug your web application

Now you are ready for a test run. Hit F5 to test your add-in.

## Using Docker to run this sample

Included with this sample is a Dockerfile for launching the add-in in a Windows container. To run this sample using Docker, along with Visual Studio 2015 and an Office 365 Developer Subscription, you'll need:

1. Windows 10 Anniversary Update or Windows Server 2016
2. [Docker for Windows](https://docs.docker.com/docker-for-windows/) (Windows containers only supported in the Beta channel at this time)

### Step 1: Build and publish the Project

1. Open the project in Visual Studio 2015
2. Simply Build the project to restore NuGet packages
3. In the Solution Explorer, click on FabricSharePointAddin.SharePoint project
4. In the Properties Window, scroll to reveal the Site URL property and enter your SharePoint developer site URL
5. Right-click on the web application, and select "Publish"
6. Choose the pre-populated "containerImage" publish profile, and click "Publish"

### Step 2: Build the Docker image and retrieve a container IP address (temporary step due to known issue in WinNAT; will be resolved in future)

1. In the root of the solution directory, execute the following commands:

    ```
    docker build -t fabricsharepointaddin .
    docker run -d --name fabricsharepointaddin fabricsharepointaddin
    ```

2. Retrieve the IP address of the running container ():

    ```
    docker inspect --format="{{.NetworkSettings.Networks.nat.IPAddress}}" fabricsharepointaddin
    ```

    Save this IP address in a temporary location

3. Remove the container:

    ```
    docker rm -f fabricsharepointaddin
    ```

### Step 3: Register and publish the SharePoint add-in

1. Navigate to your SharePoint developer site
2. Uninstall any existing instances of the add-in from your site and remove the deleted instances from the Recycle Bin and Second-Stage Recycle Bin
3. Create a new add-in registration at the following URL: `https://<your_sharepoint_site/_layouts/15/appregnew.aspx`

    Use the container IP address you retrieved earlier as the App Domain. Your redirect URI should be: `https://<container_ip>`
4. Replace the ClientId and ClientSecret values in the Web.Docker.config file with the generated values
5. Make sure the "Docker" configuration is selected in Visual Studio, right-click on the FabricSharePointAddin.SharePoint project and select "Publish"
6. Click on the "Package the add-in" button
7. Enter the following URL as the entrypoint: `https://<ip_address_from_earlier>`
8. Paste the ClientId that was generated in to the Client ID field and click "Publish"
9. Upload the package to your SharePoint app catalog and install it on your dev site

### Step 4: Rebuild the project and the Docker image and run the container

1. Right-click on the web application in Visual Studio, and select "Publish"
2. Choose the "containerImage" publish profile, and click "Publish" 
3. Execute the following commands:

    ```
    docker build -t fabricsharepointaddin .
    docker run -d --name fabricsharepointaddin -p 443:443 --ip='<ip_address_from_earlier>' fabricsharepointaddin
    ```

2. Navigate to your SharePoint site and launch the add-in. The add-in from the running Windows container should be displayed