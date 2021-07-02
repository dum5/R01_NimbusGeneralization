clear all 
close all

% cd '/Volumes/Users/Dulce/R01_Nimbus2021/SpeedAnalysis'
% group{1}= adaptationData.createGroupAdaptData({'NTS_01params','NTS_02params','NTS_03params','NTS_04params'});
% group{1}= adaptationData.createGroupAdaptData({'NTR_01params','NTR_02params','NTR_03params','NTR_04params'});
group{1}= adaptationData.createGroupAdaptData({'NTR_04params'});
% group{3}= adaptationData.createGroupAdaptData({'Dulce_Leftparams'});
group{2}= adaptationData.createGroupAdaptData({'CTR_01params'});
% group{4}= adaptationData.createGroupAdaptData({'CTR_00params'});
% group{2}= adaptationData.createGroupAdaptData({'CTR_00_2params','ShuqiSpeedTestparams','DulceSpeedTestparams','MackSpeedTestparams'});
% group{2}= adaptationData.createGroupAdaptData({'CTR_02_kin_28-Jun-2021params'});

conditions={'TR base','Adapt'}; %'Pos Short','Neg Short',
params={'singleStanceSpeedSlow','singleStanceSpeedFast'}; %you can plot which ever parameter you are interested on check into the adaptData.data for labels
% params={'singleStanceSpeedSlowAbsANK','singleStanceSpeedFastAbsANK','singleStanceSpeedDiffAbsAnk'};


poster_colors;
colorOrder=[p_red; p_orange; p_fade_green; p_fade_blue; p_plum; p_green; p_blue; p_fade_red; p_lime; p_yellow; [0 0 0];[0 1 1]];
    
binwidth=5; %Window of the running average
trialMarkerFlag=0; %1 if you want to separete the time course by trial 0 to separece by condition 
indivFlag=0; %0 to plot group mean 1 to plot indiv subjects
indivSubs=[]; %Use when you want to plot a specidfic subject in a group 
colorOrder=[];%[p_red; p_orange; p_plum;p_fade_green]; %Let the function take care of this at least you wanted in a specific set of color then by my guess and add the list here
biofeedback= 0; % At least that you are providing with biofeedback to the subject
removeBiasFlag=0; %if you want to remove bias 
labels=[]; %Groups names 
filterFlag=[]; 
plotHandles=[];
alignEnd=0; % # strides align at the end of the trial (PLAY with it as see what happens)
alignIni=0; %  # strides align at the beginning of the trial (PLAY with it as see what happens) 

adaptData=cellfun(@(x) x.adaptData,group,'UniformOutput',false); %Notice that adaptDataGroups(1) decide that I only want to plot the CG group 
[figh,avg,indv]=adaptationData.plotAvgTimeCourse(adaptData,params,conditions,binwidth,trialMarkerFlag,...
    indivFlag,indivSubs,colorOrder,biofeedback,removeBiasFlag,labels,filterFlag,plotHandles,alignEnd,alignIni);
% figure(1)
% % set(gcf,'position',[500 200 1000 600])
% findobj(gcf,'type','axes');
% % yline(nanmean(avg(2).singleStanceSpeedSlow.Adapt.trial1));
% subplot()
% % subplot(1,4,1,'singleStanceSpeedSlow')
% yline(nanmean(avg(2).singleStanceSpeedFast.Adapt.trial1));
% 
% % subplot([0.046875,0.546296296296296,0.942708333333333,0.418518518518519])
% % yline(nanmean(avg(2).singleStanceSpeedSlow.Adapt.trial1))
% % subplot([0.046875,0.046296296296296,0.942708333333333,0.418518518518519])
% % yline(nanmean(avg(2).singleStanceSpeedFast.Adapt.trial1))
% 
% set(gcf,'color','w');
% 
%  
% %%
% nanmean(avg(1).singleStanceSpeedDiff.Adapt.trial1(end-40:end))
% nanmean(avg(2).singleStanceSpeedDiff.Adapt.trial1(end-40:end))
% nanmean(avg(4).singleStanceSpeedDiff.Adapt.trial1(end-40:end))
% nanmean(avg(5).singleStanceSpeedDiff.Adapt.trial1(end-40:end))

%%
% nanmean(avg(1).singleStanceSpeedDiffAbsAnk.Adapt.trial1(end-40:end))
% nanmean(avg(2).singleStanceSpeedDiffAbsAnk.Adapt.trial1(end-40:end))
% nanmean(avg(3).singleStanceSpeedDiffAbsAnk.Adapt.trial1(end-40:end))
%%

% Fast=nanmean(avg(1).singleStanceSpeedFast.TRbase.trial1(561-40:561))/nanmean(avg(2).singleStanceSpeedFast.Adapt.trial1(end-40:end))
% Slow=nanmean(avg(1).singleStanceSpeedSlow.TRbase.trial1(561-40:561))/nanmean(avg(2).singleStanceSpeedSlow.Adapt.trial1(end-40:end))

Fast=nanmean(avg(1).singleStanceSpeedFast.Adapt.trial1(561-40:561))/nanmean(avg(2).singleStanceSpeedFast.Adapt.trial1(end-40:end))
Slow=nanmean(avg(1).singleStanceSpeedSlow.Adapt.trial1(561-40:561))/nanmean(avg(2).singleStanceSpeedSlow.Adapt.trial1(end-40:end))

% W_NTR_G=nanmean(avg(2).singleStanceSpeedFast.Adapt.trial1(end-40:end))/nanmean(avg(4).singleStanceSpeedFast.Adapt.trial1(end-40:end))
% W_NTR1=nanmean(indv(2).singleStanceSpeedFast.Adapt.trial1(1,end-40:end))/nanmean(avg(4).singleStanceSpeedFast.Adapt.trial1(end-40:end))

% AvgAll=nanmean([W_NTS,W_NTR_G,W_NTR1])

% {'OG base','TM slow','TM tied 1','Pos short','TM tied 2','Neg short','TM tied 3','TR base','TM fast','Adaptation','Post 1','Post 2'}