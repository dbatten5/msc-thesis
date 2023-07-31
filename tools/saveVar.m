function saveVar(file,varName)
try
    save(file,varName,'-append');
catch
    save(file,varName);
end

