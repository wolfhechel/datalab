FROM jupyter/tensorflow-notebook:latest

USER root

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    'cmake' \
    'pkg-config' && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

RUN mamba install --yes -c conda-forge \
    'gdal' \
    'ghostscript' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN pip install --no-cache-dir \
    openpyxl \
    tqdm \
    seaborn \
    opencv-python \
    camelot-py[base] \
    pymupdf \
    nltk \
    spacy \
    flair \
    geopy \
    geopandas \
    fiona \
    geojson \
    sentinelsat \
    folium \
    rasterio && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

COPY jupyter_server_config.py /etc/jupyter/

USER root
RUN fix-permissions /etc/jupyter

USER ${NB_USER}
