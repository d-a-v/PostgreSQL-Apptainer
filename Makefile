
IMAGE=bin/postgres.simg

default: apptainer

image: ${IMAGE}
${IMAGE}: Singularity
	sudo singularity build $(@).partial $(<)
	mv $(@).partial $(@)

apptainer: bin/apptainer-temp.simg
bin/apptainer-temp.simg: Singularity
	APPTAINERENV_APT_PROXY=http://$(shell hostname):3142 apptainer build $(@).partial $(<)
	mv $(@).partial ${IMAGE}
