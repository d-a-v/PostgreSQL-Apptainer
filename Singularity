Bootstrap: docker
#From: ubuntu:20.04  # focal
From: ubuntu:22.04   # jammy

%labels
	Maintainer glentner@purdue.edu

%post
	export TIMESCALEDB_VERSION=2
	export POSTGRESQL_VERSION=14

    ###################################################
	export DEBIAN_FRONTEND=noninteractive
    export LANG=C
    export LC_ALL=C
    if [ -z "${APT_PROXY}" ]; then
        echo "====================================="
        echo "Before building, you should apt install apt-cacher-ng"
        echo "and export APPTAINERENV_APT_PROXY=http://\$(hostname):3142"
        echo "====================================="
        sleep 10
    else
        echo "Using APT proxy: ${APT_PROXY}"
        echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/00proxy
    fi
    apt -y update
    ###################################################

	apt install -y curl openssh-client

	curl -s https://packagecloud.io/install/repositories/timescale/timescaledb/script.deb.sh | bash
	apt install -y timescaledb-${TIMESCALEDB_VERSION}-postgresql-${POSTGRESQL_VERSION}

	ln -s /etc/postgresql/${POSTGRESQL_VERSION} /etc/postgresql/cur
	ln -s /usr/lib/postgresql/${POSTGRESQL_VERSION} /usr/lib/postgresql/cur
	ln -s /var/lib/postgresql/${POSTGRESQL_VERSION} /var/lib/postgresql/cur
	mkdir -p /scratch /depot /apps
	chmod -R +rx,o-rwx /etc/ssl/private
	chmod -R +r,o-rwx /etc/postgresql

%environment
	export LANG=C
	export LC_ALL=C
	export PATH=$PATH:/usr/lib/postgresql/cur/bin

%runscript
	postgres -c config_file=/etc/postgresql/cur/main/postgresql.conf "$@"
