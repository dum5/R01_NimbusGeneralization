function [eps] = defineEpochNimbusShoes_longProtocol(nantype)

% names={'Base', 'EarlyA', 'LateA' ,'EarlyP', 'LateP'};

names={'OGBase','TMBaseFast','SplitPos','OGPosShort_{early}',...
    'TM slow','SplitNeg','OGNegShort_{early}','OGNimbus','Adaptation',...
    'Post1-Adapt_{SS}','Post1_{Early}','Post1_{Late}','Post2_{Early}','Post2_{Late}',...
    'TM fast2','NegPlusDelta','OGAfter_{early}','TM fast','ShortSplit(ShoeOn)',...
    'OGAfterShoe_{early}','PosShort_{late}','NegShort_{late}','NegPlusDelta_{late}','ShortSplit_{late}','TMSlowBase150'};

eps=defineEpochs(names,...
                {'OG base','TM tied 2','Pos Short','OG 2',...
                'TM slow','Neg Short','OG 3','TR base','Adaptation',...
                'Post 1','Post 1','Post 1','Post 2','Post 2',...
                'TM fast 2','Neg plus delta','OG After Neg Plus','TM fast','Short Split',...
                'OG 1','Pos Short','Neg Short','Neg plus delta','Short Split', 'TM slow base'},...
                [-40 -40 20 20,...
                -40 20 20 -40,-40,...
                5 5 -40 5 -40,...
                 -40 20 20 -40 20,...
                 20 -20 -20 -20 -20 -40],...
                [0,0,1,0,...
                0,1,1,0,0,1,...
                1,0,1,0,0,...
                1,1,0,1,1,...
                0,0,0,0,0],...
                [5,5,0,0,...
                5,0,0,5,5,...
                0,0,5,0,5,...
                5,0,0,5,0,...
                0,1,1,1,1,5],... %only exclude last 1 for the short split 
                nantype);