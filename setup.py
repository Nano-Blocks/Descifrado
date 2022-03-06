# makes myapp firectory into an editable package for tests [applicable only within the project]
import setuptools

packages = setuptools.find_packages(exclude=['docs', 'tests'])
setuptools.setup(name='descifrado', version='0.0.1', packages=packages)
