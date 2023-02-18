# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
# mypy: ignore-errors
import os

c = get_config()  # noqa: F821
c.ServerApp.ip = "0.0.0.0"
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.notebook_dir = os.path.join(os.getenv('HOME'), 'work')
c.ServerApp.token = ''
c.InlineBackend.figure_formats = {"png", "jpeg", "svg", "pdf"}
c.FileContentsManager.delete_to_trash = False
