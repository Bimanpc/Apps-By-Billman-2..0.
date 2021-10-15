from cx_Freeze import setup, Executable


nameOfExec = input("Name for Executable: ")
versionNumber = input("Version: ")
auth = input("Name of Author: ")
auth_email = input("Email of Author: ")
descript = input("Description: ")
filename = input("File to Compile(Add .py to file): ")

# run this file in cmd "python CompileFiles.py build" or "python CompileFiles.py build_exe"
# This setup in minimialistic

setup(
    name = nameOfExec,
    version = versionNumber,
    description = descript, 
    author = auth,
    author_email = auth_email,
    executables = [Executable(filename)]
    )
