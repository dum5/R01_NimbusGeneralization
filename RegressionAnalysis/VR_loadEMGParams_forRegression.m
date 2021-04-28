% function loadEMGParams_forRegression(groupName)
%% Aux vars:
% matDataDir='../data/HPF30/';
% loadName=[matDataDir 'groupedParams'];
% loadName=[loadName '_wMissingParameters']; %Never remove missing for this script

% group=adaptationData.createGroupAdaptData({'VrG_Devonparams'});

loadName='VR_Devon.mat';
load(loadName)


%%
% if  isempty(loadName)
%     group=TMFullAbrupt;
% else
%     eval(['group=' groupName ';']);
% end
age=group.getSubjectAgeAtExperimentDate/12;

%% Define params we care about:
mOrder={'TA', 'PER', 'SOL', 'LG', 'MG', 'BF', 'SEMB', 'SEMT', 'VM', 'VL', 'RF', 'TFL', 'GLU', 'HIP'};

nMusc=length(mOrder);
type='s';
labelPrefix=fliplr([strcat('f',mOrder) strcat('s',mOrder)]); %To display
labelPrefixLong= strcat(labelPrefix,['_' type]); %Actual names
baseEp=getBaseEpochVR_OG;
% ep=defineEpocVR_OG('nanmean');
% baseEp=defineReferenceEpoch('TMbase',ep);

%Adding alternative normalization parameters:
l2=group.adaptData{1}.data.getLabelsThatMatch('^Norm');
group=group.renameParams(l2,strcat('N',l2)).normalizeToBaselineEpoch(labelPrefixLong,baseEp,true); %Normalization to max=1 but not min=0

%Renaming normalized parameters, for convenience:
ll=group.adaptData{1}.data.getLabelsThatMatch('^Norm');
l2=regexprep(regexprep(ll,'^Norm',''),'_s','s');
group=group.renameParams(ll,l2);
newLabelPrefix=strcat(labelPrefix,'s');

%% Define epochs & get data:
ep=getEpochsVR_OG('nanmean');

baseEp=getBaseEpochVR_OG;
% baseEp=defineReferenceEpoch('TMbase',ep); 
padWithNaNFlag=false;
[dataEMG,labels]=group.getPrefixedEpochData(newLabelPrefix,ep,padWithNaNFlag);
[BB,labels]=group.getPrefixedEpochData(newLabelPrefix,baseEp,padWithNaNFlag);
dataEMG=dataEMG-BB; %Removing base
%Flipping EMG:
dataEMG=reshape(flipEMGdata(reshape(dataEMG,size(labels,1),size(labels,2),size(dataEMG,2),size(dataEMG,3)),1,2),numel(labels),size(dataEMG,2),size(dataEMG,3));



% [dataContribs]=group.getEpochData(ep,{'netContributionNorm2'},padWithNaNFlag);
% dataContribs=dataContribs-dataContribs(:,strcmp(ep.Properties.ObsNames,'Base'),:); %Removing base

%% Get all the eA, lA, eP vectors
% shortNames={'lB','eA','lA','lS','eP','ePS','veA','veP','veS','vePS','lP','e15A','e15P'};
% longNames={'Base','early A','late A','Short','early P','early B','vEarly A','vEarly P','vShort','vEarly B','late P','early A15','early P15'};

shortNames={'TMBl','TMtied','Pos','Neg','OGlbase','SS','eP'};
longNames={'TMbase','TMtied','SplitPos','SplitNeg','OGbase','Adaptation','OGpostEarly'};
for i=1:length(shortNames)
    aux=squeeze(dataEMG(:,strcmp(ep.Properties.ObsNames,longNames{i}),:));
    eval([shortNames{i} '=aux;']);
%     aux=squeeze(dataContribs(:,strcmp(ep.Properties.ObsNames,longNames{i}),:));
%     eval(['SLA_' shortNames{i} '=aux(:);']);
end
clear aux
groupName='OG_VR';
% vars=[shortNames,strcat('SLA_',shortNames), {'age','labels'}];
vars=[shortNames, {'age','labels'}];
save([groupName 'EMGsummary'],vars{:})
% end

%% Now that we have the data we can start doing the regression 
subjIdx=1;
muscleIdx=1:size(eP,1);
tt=table(median(TMBl(muscleIdx,subjIdx),2), median(TMtied(muscleIdx,subjIdx),2), median(Pos(muscleIdx,subjIdx),2),...
           median(Neg(muscleIdx,subjIdx),2),  median(OGlbase(muscleIdx,subjIdx),2),...
        median(SS(muscleIdx,subjIdx),2), median(eP(muscleIdx,subjIdx),2),...
        median(TMBl(muscleIdx,subjIdx),2)-median(Pos(muscleIdx,subjIdx),2),...
        median(Neg(muscleIdx,subjIdx),2) - median(TMtied(muscleIdx,subjIdx),2),...
        median(OGlbase(muscleIdx,subjIdx),2) - median(SS(muscleIdx,subjIdx),2),...
        median(eP(muscleIdx,subjIdx),2) - median(SS(muscleIdx,subjIdx),2),...
        'VariableNames',{'TMBl','TMtied','Pos','Neg','OGlbase','SS','eP','TMtied_Pos','Neg_TMtied','OGb_SS','eP_SS'});


modelFit2=fitlm(tt,'eP_SS~TMtied_Pos+Neg_TMtied+OGb_SS-1','RobustOpts',rob)
learnS3a=modelFit2.Coefficients.Estimate;
learnS3aCI=modelFit2.coefCI;
r2S3a=uncenteredRsquared(modelFit2);
r2S3a=r2S3a.uncentered;
disp(['Uncentered R^2=' num2str(r2S3a,3)])