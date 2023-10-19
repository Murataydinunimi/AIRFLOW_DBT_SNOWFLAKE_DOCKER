# Use a base image (Debian 10) that supports Python
FROM debian:10

# Update package lists
RUN apt-get update
# Install Python 3 and pip
RUN apt-get install -y python3 python3-pip

# Update pip to the latest version
RUN python3 -m pip install --upgrade pip

# install openssl version 1.1.1
RUN apt-get update && apt-get install -y libssl1.1

WORKDIR /usr/app

COPY requirements.txt ./

# Install Python Requirements
RUN pip install --no-cache-dir -r requirements.txt

# Create alias for dbt-set-profile
RUN echo "alias dbt-set-profile='unset DBT_PROFILES_DIR && export DBT_PROFILES_DIR=\$PWD'" >> .bashrc

CMD ["dbt", "--version"]