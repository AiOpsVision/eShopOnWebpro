FROM jenkins/jenkins:lts-jdk17

USER root

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io


RUN apt-get update && \
    apt-get install -y wget apt-transport-https software-properties-common && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y dotnet-sdk-8.0
	
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --no-cache-dir --upgrade boto3 botocore
	
RUN wget https://releases.hashicorp.com/terraform/1.8.4/terraform_1.8.4_linux_amd64.zip && \
    unzip terraform_1.8.4_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.8.4_linux_amd64.zip

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible


ENV DOTNET_ROOT="/usr/share/dotnet"
ENV PATH="$PATH:/usr/share/dotnet"
	
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

RUN echo $JENKINS_VERSION > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state \
    && echo $JENKINS_VERSION > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion