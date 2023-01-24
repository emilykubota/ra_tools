%% montage and save
clc;clear;close all;

imgpath = '/share/kalanit/biac2/kgs/projects/Emily/RAs/code/ra_tools/fs_screenshots/figures';
figure('units','normalized','outerposition',[0 0 1 1],'color','w')
n=0;
hems = {'lh','rh'};

for h = 1:2
    for i = 1:8 % there are 8 NSD subs
        subj = ['subj0',int2str(i)];
        cd(imgpath)
        imname = [hems{h},'_',subj,'.png'];
        if exist(imname)
            n=n+1;
            subplot_tight(2,4,n,[0.02 0.02])
            img = imread(imname);
            imshow(img);
            if strmatch(hems{h},'lh')
                
                imshow(img(80:end,350:600,:));
            elseif strmatch(hems{h},'rh')
                imshow(img(80:end,125:325,:));
            end
            title(subj,'color','k','fontsize',6)
        end
    end
    
    figname = [hems{h},'_montage.png'];
    saveas(gcf,fullfile(imgpath,figname));
end



