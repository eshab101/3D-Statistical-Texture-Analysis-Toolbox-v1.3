function nii=load_untouch_niigz(file_nii_gz)

    gunzip(file_nii_gz);
    [pathstr, str_file_nii] = fileparts(file_nii_gz);
    nii=load_untouch_nii(fullfile(pathstr,str_file_nii));
    delete(fullfile(pathstr,str_file_nii));

end