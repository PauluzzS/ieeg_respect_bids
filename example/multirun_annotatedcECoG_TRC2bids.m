%% example multiple cecog TRC to bids
% Convert all selected files to BIDS. Output variables of annotatedTRC2bids
% are stored in cell arrays.
%
% make sure you have the toolboxes jsonlab and fieldtrip available

addpath('~/git/ieeg_respect_bids/trc2bids/')
addpath('~/git/ieeg_respect_bids/micromed_utils/')
addpath('~/git/ieeg_respect_bids/external/')

fieldtrip_folder  = '~/git/fieldtrip/';
% copy the private folder in fieldtrip to somewhere else
fieldtrip_private = '~/git/fieldtrip_private/';
jsonlab_folder    = '~/git/jsonlab/';
addpath(fieldtrip_folder) 
addpath(fieldtrip_private)
addpath(jsonlab_folder)

%% TRC to bids

cfg.proj_dirinput = '/home/paul/bulk/smb-share:server=10.121.48.169,share=willemiek/Paul_annotation/Patients/PAT_2';
cfg.proj_diroutput = '/home/paul/ecog_BIDS';

[filename, pathname] = uigetfile('*.TRC;*.trc','Select *.TRC file',[cfg.proj_dirinput],'MultiSelect','on');

pathsplit = strsplit(pathname,{'/'});
patient = pathsplit{end-1};
files = regexprep(filename,'EEG_(\d+).TRC','$1')';
nf=numel(filename);
%%
status=nan(nf,1); msg=cell(nf,1); output=cell(nf,1); metadata=cell(nf,1);
annots=cell(nf,1);

%%
for i=1:nf
    file=files{i};
    cfg.filename = [pathname,filename{i}];
    fprintf('Running %s, writing EEG: %s to BIDS \n', patient,file)
    [status(i),msg{i},output{i},metadata{i},annots{i}] = annotatedTRC2bids(cfg);
        % status is double array with logical values
end
fprintf('Done writing %s, %u trace(s) require(s) attention. See msg for status=1\n', patient,sum(status));
%%
% 
% [status1,msg1,output1,metadata1,annots1] = annotatedTRC2bids(cfg)

