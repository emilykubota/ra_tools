function fsTakescreenshots(fs_dir, subj, hemi, map_name,overlay_thresh,...
    label_list, color_list, label_outline,view, title)
% Description: this script opens freeview and takes a screenshot of a given
% subject and map/label, view

%% Inputs: for example
% (1) name of freesurfer subjects directory 
% (2) name of fs subject, subj = 'subj01';
% (3) hemi - 'lh' or 'rh' 
% (4) map_name = 'lh.flocfacestval', can also
% be '' if no map should be loaded
% (5) overlay_thresh: threshold for map (default: [3,10] can be '' if no map)
% (6) label_list, for example labelList={['lh_mOTS.label','lh_pOTS.label',
% 'lh_mFus.label','lh_pFus.label','lh_PPA.label','lh_OTS.label'])  
% (7)  color_list for labels
%  color_list = {'#ADD8E6','#000080','#FF7F7F','#8b0000','#00FF00','#FFFF00'}
% (8) label_outline = set here if label should be displayed as outline (1) or not (0)
% (9) view='ventral' or 'lateral'
% (10) optional:  title for image/screenshot (fullpath)

%% view settings
% Set here the view settings, this is for ventral view
if strcmp(view, 'ventral')
    settingsView = ' -cam dolly 1.2 azimuth 180 elevation 270 roll 270';
elseif strcmp(view, 'lateral')
%    settingsView = ' -cam dolly 1.2 azimuth 10 elevation -21 roll 0';
settingsView = ' -cam dolly 1.2 azimuth 0 elevation 0 roll 0';
else
    sprintf('THis view has not yet been defined. Choose ventral or lateral')
end

% set here if label should be displayed as outline (1) or not (0)
labelOutlineFlag = [':label_outline=',int2str(label_outline)];

screenshotCmd = ' -ss screenshot';


%% directory
% move into subj directory
cd([fs_dir subj])

freeviewCMD = sprintf('freeview -f surf/%s.inflated:curvature_method=binary', hemi);

%% load map and label if applicable on surface in freeview, set 3d view  and rotate to  view, take screenshot

if isempty(overlay_thresh)
    overlay_thresh = [3,10];
end 
if ~isempty(map_name)
    % Setting to threshold overlay at 3 and don't show negative vals
    overlayThreshold = [':overlay_threshold=',int2str(overlay_thresh(1)),...
        ',',int2str(overlay_thresh(2)),':overlay_color=heat'];
    freeviewCMD = [freeviewCMD [':overlay=',  map_name, overlayThreshold]] ;
end
if ~isempty(label_list)
    labelCMD ='';
    for l=1:length(label_list)
        labelName=label_list{l};
        colorname=color_list{l};
        %colorname = 'white';
        if exist(fullfile(fs_dir,subj,'label',labelName),'file')
            
            labelCMD = [labelCMD sprintf(':label=label/%s%s:label_color=%s', labelName,labelOutlineFlag, colorname)];
        end
    end
    
    freeviewCMD = [freeviewCMD labelCMD];
end
freeviewCMD = [freeviewCMD sprintf(' --viewport 3D %s %s', settingsView, screenshotCmd)];
unix(freeviewCMD)

%% finally rename screenshot

if isempty(title)
    % make compatibile for old matlab version
    idx= strfind(map_name, '_');
    timepoint=map_name(idx(end-3)+1:idx(end-1)-1);
    contrast=map_name(idx(1)+1:idx(end-4)-1);

    imageName = sprintf('%s_%s_%s_%sView.png', hemi, contrast, timepoint, view);
else
    imageName=title; 
end
movefile('screenshot.png', imageName);

end
