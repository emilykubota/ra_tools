
%% here is an example of plotting out a label and a map for a single subject
% 
fs_dir = '/share/kalanit/biac2/kgs/projects/Emily/neurohackademy/freesurfer/';
subj = 'subj01';
hemi = 'lh';
map_name = fullfile(fs_dir,subj,'label','lh.flocfacestval.mgz');
overlay_thresh=[];
label_list = {'lh_pFus_faces_t3_ek.label'}; 
color_list ={'black'};
label_outline = 1;
view = 'ventral';
outpath = '/share/kalanit/biac2/kgs/projects/Emily/RAs/code/ra_tools/fs_screenshots/figures';
title= fullfile(outpath,'example.png');


fsTakescreenshots(fs_dir, subj, hemi, map_name,overlay_thresh,...
    label_list, color_list, label_outline,view, title)

%% or we can plot out the overlays for all of the subjects 

fs_dir = '/share/kalanit/biac2/kgs/projects/Emily/neurohackademy/freesurfer/';
overlay_thresh=[];
label_list = {};
color_list ={};
label_outline = 1;
view = 'ventral';
outpath = '/share/kalanit/biac2/kgs/projects/Emily/RAs/code/ra_tools/fs_screenshots/figures';

hems = {'lh','rh'};
for h = 1:2 % for each hemi
    for s = 1:8 % for each sub
        subj = ['subj0',int2str(s)];
        map_name = fullfile(fs_dir,subj,'label',[hems{h},'.flocfacestval.mgz']);
        title= fullfile(outpath,[hems{h},'_',subj,'.png']);
        
        fsTakescreenshots(fs_dir, subj, hems{h}, map_name,overlay_thresh,...
            label_list, color_list, label_outline,view, title)
    end
end