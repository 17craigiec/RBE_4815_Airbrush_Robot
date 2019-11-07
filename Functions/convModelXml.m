function xml = convModelXml(model)
    file1= model;
    file2=strrep(file1,'.model','.xml');
    copyfile(file1,file2);
    xml = file2;
end

