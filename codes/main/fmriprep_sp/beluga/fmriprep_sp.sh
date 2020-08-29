#!/bin/bash
DATA_NAME=(${@:1:1})
echo ${DATA_NAME}

WD_DIR=${HOME}/scratch
DATA_DIR=${WD_DIR}/${DATA_NAME}
BIDS_DIR=${DATA_DIR}_BIDS
CODE_DIR=${WD_DIR}/src
CODE_SLURM=${CODE_DIR}/fmriprep_sp.slurm
CODE_COLLECT=${CODE_DIR}/fmriprep_sp.format

CON_IMG_DIR=${WD_DIR}/container_images/fmriprep_v20.1.1.simg

OUT_DIR=${DATA_DIR}_fmriprep_20.1.1_sp
LOG_DIR=${DATA_DIR}_fmriprep_sp.log
SLURM_LOG_DIR=${DATA_DIR}_fmriprep_sp_slurm_log
WORK_DIR=${DATA_DIR}_fmriprep_sp_work

FREESURFER_LICENSE="${WD_DIR}/container_images"
TEMPLATEFLOW_HOST_HOME=$HOME/scratch/templateflow

RUN_ID=$(tail -c 9 ${LOG_DIR})
if [ -z $RUN_ID ];then
  echo 'no previous run found...'
else
  echo "previous run $RUN_ID found, deleting logs..."
  rm fmriprep_vince-${RUN_ID}*.out
  rm fmriprep_vince-${RUN_ID}*.err
fi

rm -rf ${OUT_DIR}
rm -rf ${WORK_DIR}
rm -rf ${SLURM_LOG_DIRDIR}
rm -rf ${SUB_LIST}

chmod +x ${CODE_SLURM}
chmod +x ${CODE_COLLECT}

mkdir -p ${OUT_DIR}
mkdir -p ${WORK_DIR}
mkdir -p ${SLURM_LOG_DIR}

echo "Step1: subjects folder created!"
echo "Step2: starting fmriprep-SP!"
echo "Submitting sub-1690, sub-1920, sub-2400, sub-3900 ses-2!"
SUB_ID=sub-1690
SES_ID=ses-2.json
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
SUB_ID=sub-1920
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
SUB_ID=sub-2400
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
SUB_ID=sub-3900
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
echo "Submitting sub-1690, sub-1920, sub-2400, sub-3900 ses-3!"
SUB_ID=sub-1920
SES_ID=ses-3.json
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
SUB_ID=sub-2400
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
SUB_ID=sub-3900
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
echo "Submitting sub-1920 ses-4!"
SUB_ID=sub-1920
SES_ID=ses-4.json
mkdir -p ${OUT_DIR}/${SUB_ID}_${SES_ID}
sbatch ${CODE_SLURM} ${DATA_NAME} ${CON_IMG_DIR} ${SUB_ID} ${SES_ID} >> ${LOG_DIR}
echo "Submission finished!"
