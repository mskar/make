CONDA_ROOT = ~/miniconda
ENV_NAME = my-env
ENV_PATH = ${CONDA_ROOT}/envs/${ENV_NAME}
ENV_FILE = environment.yml
ENV_TARGET = ${ENV_PATH}/bin/activate
PYTHON = ${ENV_PATH}/bin/python
PIP = ${ENV_PATH}/bin/pip

env: ${ENV_TARGET}

${ENV_TARGET}:
	conda env create --name ${ENV_NAME} --file ${ENV_FILE}
	touch ${ENV_TARGET}

update: ${ENV_FILE}
	conda env update --name ${ENV_NAME} --file ${ENV_FILE}

install: setup.py
	${PIP} install --upgrade pip
	${PIP} install --editable .

test: env
	${PYTHON} -m pytest -x

lint: env
	${PYTHON} -m black -l 79
