
IMAGE=bin/postgres.simg

image: ${IMAGE}
${IMAGE}: Singularity
	sudo singularity build $(@).partial $(<)
	mv $(@).partial $(@)

apptainer: bin/apptainer-temp.simg
bin/apptainer-temp.simg: Singularity
	apptainer build $(@).partial $(<)
	mv $(@).partial ${IMAGE}
