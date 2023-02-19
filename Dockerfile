FROM jupyter/tensorflow-notebook:latest

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    'cmake' \
    'pkg-config' && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

COPY --chown=${NB_UID}:${NB_GID} *-packages.txt /tmp/

RUN mamba install --yes \
    -c conda-forge \
    --file /tmp/conda-packages.txt && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}"

RUN pip install --no-cache-dir -r /tmp/pip-packages.txt && \
    fix-permissions "/home/${NB_USER}"

COPY jupyter_server_config.py /etc/jupyter/

USER root
RUN fix-permissions /etc/jupyter

USER ${NB_USER}
