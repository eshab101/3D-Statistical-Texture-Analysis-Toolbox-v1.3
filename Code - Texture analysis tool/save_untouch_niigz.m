function save_untouch_niigz(file_mat,file_nii_gz,file_header)

    file_struct=load_untouch_niigz(file_header);
    file_struct.img=file_mat;
    file_struct.hdr.dime.datatype=16; file_struct.hdr.dime.bitpix=32;
    file_struct.hdr.dime.dim(2:end)=ones(1,length(file_struct.hdr.dime.dim)-1);
    file_struct.hdr.dime.dim(2:length(size(file_struct.img))+1)=size(file_struct.img);
    file_struct.hdr.dime.dim(1)=ndims(file_struct.img);
    

    [pathstr, str_file_nii] = fileparts(file_nii_gz);
    save_untouch_nii(file_struct,fullfile(pathstr,str_file_nii));
    gzip(fullfile(pathstr,str_file_nii));
    delete(fullfile(pathstr,str_file_nii));

end