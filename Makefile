
IMAGE=bin/postgres.sif

default: image

image: ${IMAGE}

${IMAGE}: Apptainer
	#APPTAINERENV_APT_PROXY=http://$(shell hostname):3142 apptainer build $(@).temp $(<)
	apptainer build $(@).temp $(<)
	mv $(@).temp ${IMAGE}
