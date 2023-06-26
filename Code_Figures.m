
%% Figure 1a
%% spatial pattern of treeline elevation 
clear all
data = xlsread('G:\cp xinyue_code\2_treeline\find_elevation_info\allrounds\remain_individual\summary1.xlsx'); 
latitude =data(:,3);longtitude=data(:,6);elevation=data(:,9); 
mt = shaperead('E:\OneDrive - University of Leeds\backup_onedrive\mountainforests_backup\datasets\GMBA dissolve\GMBAdissolve.shp','UseGeoCoords',true);
load('E:\OneDrive - University of Leeds\backup_onedrive\phd_study\code\matlab practice\colorbar_matlab\matlab_hot_r.mat');
load coast
long(lat<-56)=nan;
lat(lat<-56)=nan;
[LON,LAT]=meshgrid(-180:0.5:179.5,90:-0.5:-89.5);

fig1 = figure('units','centimeters','position',[5,1.5,18,10]);
ax2 = axes;
set(ax2,'position',[0 0 1 1]);
axesm('MapProjection','robinson','MapLatLimit',[-90 90],'MapLonLimit',[-180 180],'frame','off','grid','on','MLineLocation',20,...
    'MeridianLabel','off','MLabelParallel','south', 'PLineLocation',10,'ParallelLabel','off','PLabelMeridian','east','FontSize',20)
hold on;
h2 = framem;
set(h2,'LineWidth',0.5)
set(gca,'Visible','off')
plotm([mt.Lat],[mt.Lon],'-','LineWidth',0.1,'Color',[128 128 128]/255)
plotm(lat,long,'-k','LineWidth',0.5)
scatterm(latitude,longtitude,8,elevation,'filled');
caxis([0 4000])
colormap(ax2,matlab_hot_r)
h = colorbar('location','northoutside');
set(h,'position',[0.245 0.16 0.5 0.025],'xtick',0:500:4000,'xticklabel',{'0','500','1,000','1,500','2,000','2,500','3,000','3,500','>4,000'},'FontSize',9);
h1 = text(-0.5,-1.5,'CLMT elevation (m)','FontSize',10);
set(h1,'Position',[-0.45,-0.92])
set(gcf, 'renderer', 'painters');

%% Figure 2
%% treeline elevation against lon/lat 
clear all
[summary_regions] = xlsread('G:\cp xinyue_code\2_treeline\find_elevation_info\allrounds\remain_individual\summary1_byregion1.xlsx');
load('E:\OneDrive - University of Leeds\backup_onedrive\phd_study\code\matlab practice\colorbar_matlab\MPL_RdYlBu_r.mat');
latitude = summary_regions(:,3); longtitude = summary_regions(:,6); 
elevation = summary_regions(:,9);distance = summary_regions(:,13);
x1 = latitude;
y1 = elevation;
[xData1, yData1] = prepareCurveData(x1, y1);
ft1 = fittype( 'smoothingspline' );
opts1 = fitoptions( 'Method', 'SmoothingSpline' );
opts1.SmoothingParam = 0.0005;
[fitresult1, gof1] = fit( xData1, yData1, ft1, opts1 );
x2 = longtitude;
y2 = elevation;
[xData2, yData2] = prepareCurveData(x2, y2);
ft2 = fittype( 'smoothingspline' );
opts2 = fitoptions( 'Method', 'SmoothingSpline' );
opts2.SmoothingParam = 0.0005;
[fitresult2, gof2] = fit( xData2, yData2, ft2, opts2 );

fig2 = figure('units','centimeters','position',[5,1.5,28,10]);
ax1 = axes;
set(ax1,'position',[0.08 0.12 0.38 0.85]);
errorbar(summary_regions(:,3),summary_regions(:,9),summary_regions(:,10),'.','Color',[.7 .7 .7],'CapSize',2);
hold on
s_africa = scatter(summary_regions(1:40,3),summary_regions(1:40,9),20,summary_regions(1:40,13)/1000,'d','filled'); %africa
hold on 
s_asia = scatter(summary_regions(41:598,3),summary_regions(41:598,9),20,summary_regions(41:598,13)/1000,'o','filled');%asia
hold on 
s_sa = scatter(summary_regions(599:629,3),summary_regions(599:629,9),30,summary_regions(599:629,13)/1000,'p','filled');%sa
hold on 
s_na = scatter(summary_regions(630:1513,3),summary_regions(630:1513,9),20,summary_regions(630:1513,13)/1000,'*');%na
hold on 
s_australia = scatter(summary_regions(1514:1523,3),summary_regions(1514:1523,9),20,summary_regions(1514:1523,13)/1000,'x');%australia
hold on 
s_oceania = scatter(summary_regions(1524:1616,3),summary_regions(1524:1616,9),20,summary_regions(1524:1616,13)/1000,'^','filled');%oceania
hold on 
s_europe = scatter(summary_regions(1617:1690,3),summary_regions(1617:1690,9),20,summary_regions(1617:1690,13)/1000,'s','filled');%europe
h1 = legend([s_africa(1),s_asia(1),s_sa(1),s_na(1),s_australia(1),s_oceania(1),s_europe(1)], ...
    'Africa', 'Asia', 'S America','N America', 'Australia', 'Oceania', 'Europe','location', 'northwest');
set(h1,'box','off')
colormap(MPL_RdYlBu_r)
hold on
h = plot(fitresult1,'k'); 
xlabel('Latitude (бу)');ylabel('CLMT elevation (m)');
a = text(-2.5,1.3,'(a)','FontSize',12,'FontWeight','bold')
set(a,'Position',[-85,5005])

ax2 = axes;
set(ax2,'position',[0.54 0.12 0.38 0.85]);
errorbar(summary_regions(:,6),summary_regions(:,9),summary_regions(:,10),'.','Color',[.7 .7 .7],'CapSize',2); 
hold on
s_africa = scatter(summary_regions(1:40,6),summary_regions(1:40,9),20,summary_regions(1:40,13)/1000,'d','filled'); %africa
hold on 
s_asia = scatter(summary_regions(41:598,6),summary_regions(41:598,9),20,summary_regions(41:598,13)/1000,'o','filled');%asia
hold on 
s_sa = scatter(summary_regions(599:629,6),summary_regions(599:629,9),30,summary_regions(599:629,13)/1000,'p','filled');%sa
hold on 
s_na = scatter(summary_regions(630:1513,6),summary_regions(630:1513,9),20,summary_regions(630:1513,13)/1000,'*');%na
hold on 
s_australia = scatter(summary_regions(1514:1523,6),summary_regions(1514:1523,9),20,summary_regions(1514:1523,13)/1000,'x');%australia
hold on 
s_oceania = scatter(summary_regions(1524:1616,6),summary_regions(1524:1616,9),20,summary_regions(1524:1616,13)/1000,'^','filled');%oceania
hold on 
s_europe = scatter(summary_regions(1617:1690,6),summary_regions(1617:1690,9),20,summary_regions(1617:1690,13)/1000,'s','filled');%europe
h1 = colorbar;
set(get(h1,'label'),'string','Distance to coast (km)')
set(h1,'position',[0.928 0.12 0.015 0.85],'FontSize',10);
colormap(MPL_RdYlBu_r)
hold on
h = plot(fitresult2,'k'); 
axis([-180 180,0 5000])
xlabel('Longitude (бу)');ylabel('CLMT elevation (m)');
b = text(-2.5,1.3,'(b)','FontSize',12,'FontWeight','bold')
set(b,'Position',[-245,5005])

%% Figure 3
%% climate variable importance
clear all
importance = xlsread('G:\cp xinyue_code\2_treeline\worldclim\bioclimatic\py_GradientBoostedModel\clim_6\importance.xlsx');
importance = importance*100;
temp = importance(28:35,1);temp = [temp;0;0;0;0;0;0;0;0];
prec = importance(36:43,1);prec=[0;0;0;0;0;0;0;0;prec];
temp_b = importance(28:35,5);temp_b = [temp_b;0;0;0;0;0;0;0;0];
prec_b = importance(36:43,5);prec_b=[0;0;0;0;0;0;0;0;prec_b];
temp_temp = importance(28:35,8);temp_temp=[temp_temp;0;0;0;0;0;0;0;0];
prec_temp = importance(36:43,8);prec_temp=[0;0;0;0;0;0;0;0;prec_temp];
temp_tro = importance(28:35,11);temp_tro=[temp_tro;0;0;0;0;0;0;0;0];
prec_tro = importance(36:43,11);prec_tro=[0;0;0;0;0;0;0;0;prec_tro];

fig3 = figure('unit','centimeters','position',[5,2,15,30*0.618]);
ax1 = axes; set(ax1,'position',[0.1 .1 0.85 .2])
b = bar(temp_tro,0.5);
set(b,'edgecolor','none','FaceColor',[0.75984597,0.085536003,0.10609800]);
hold on 
b1 = bar(prec_tro,0.5);
set(b1,'edgecolor','none','FaceColor',[0.10557500,0.41262600,0.68596703]);
set(gca,'xtick',1:1:16) 
ylim([0 55])
set(gca,'xticklabel',{'Annual T','T seasonality','Maximum T','Minimum T','Wet season T','Dry season T'...
    ,'Warm season T','Cold season T','Annual P','Maximum P','Minimum P','P seasonality','Wet season P'...
    ,'Dry season P', 'Warm season P','Cold season P'});
xtickangle(45); 
text(6.5,48,'T: 96%')
text(9,48,'T: 4%')
text(0.5,50,'(d)','FontWeight','bold')
text(1.2,50,'Tropical')

ax2 = axes; set(ax2,'position',[0.1 .32 0.85 .2])
b = bar(temp_temp,0.5);
set(b,'edgecolor','none','FaceColor',[0.75984597,0.085536003,0.10609800]);
hold on 
b1 = bar(prec_temp,0.5);
set(b1,'edgecolor','none','FaceColor',[0.10557500,0.41262600,0.68596703]);
set(gca,'xtick',1:1:16) 
ylim([0 55])
xticklabels('') 
text(6.5,48,'T: 45%')
text(9,48,'P: 55%')
text(0.5,50,'(c)','FontWeight','bold')
text(1.2,50,'Temperate')

ax3 = axes; set(ax3,'position',[0.1 .55 0.85 .2])
b = bar(temp_b,0.5);
set(b,'edgecolor','none','FaceColor',[0.75984597,0.085536003,0.10609800]);
hold on 
b1 = bar(prec_b,0.5);
set(b1,'edgecolor','none','FaceColor',[0.10557500,0.41262600,0.68596703]);
set(gca,'xtick',1:1:16) 
ylim([0 55])
xticklabels('') 
text(6.5,48,'T: 80%')
text(9,48,'P: 20%')
text(0.5,50,'(b)','FontWeight','bold')
text(1.2,50,'Boreal')

ax4 = axes; set(ax4,'position',[0.1 .77 0.85 .2])
b = bar(temp,0.5);
set(b,'edgecolor','none','FaceColor',[0.75984597,0.085536003,0.10609800]);
hold on 
b1 = bar(prec,0.5);
set(b1,'edgecolor','none','FaceColor',[0.10557500,0.41262600,0.68596703]);
h = legend({'Temperature','Precipitation'},'Location','Northeast');
set(h,'box','off');
set(gca,'xtick',1:1:16) 
ylim([0 55])
xticklabels('') 
text(6.5,48,'T: 64%')
text(9,48,'P: 36%')
text(0.5,50,'(a)','FontWeight','bold')
text(1.2,50,'Global')
text(-1.5,-100,'Relative importance (%)','rotation',90)

%% Figure 4
%% spatial pattern of treeline shift rate (Figure 4a)
clear all
elevation_removing= xlsread('G:\cp xinyue_code\2_treeline\rerunTC2010\new\ele1_removing_95percentile.xlsx');
longtitude = elevation_removing(:,9); latitude = elevation_removing(:,8); rate_mean = elevation_removing(:,4)/10; 
mt = shaperead('E:\OneDrive - University of Leeds\backup_onedrive\mountainforests_backup\datasets\GMBA dissolve\GMBAdissolve.shp','UseGeoCoords',true);
load('E:\OneDrive - University of Leeds\backup_onedrive\phd_study\code\matlab practice\colorbar_matlab\MPL_BrBG.mat');
load coast
long(lat<-56)=nan;
lat(lat<-56)=nan;
[LON,LAT]=meshgrid(-180:0.5:179.5,90:-0.5:-89.5);

fig = figure('units','centimeters','position',[5,1.5,18,10]);
ax = axes;
set(ax,'position',[0 0 1 1]);
axesm('MapProjection','robinson','MapLatLimit',[-90 90],'MapLonLimit',[-180 180],'frame','off','grid','on','MLineLocation',20,...
    'MeridianLabel','off','MLabelParallel','south', 'PLineLocation',10,'ParallelLabel','off','PLabelMeridian','east','FontSize',20)
hold on;
h2 = framem;
set(h2,'LineWidth',0.5)
set(gca,'Visible','off')
plotm([mt.Lat],[mt.Lon],'-','LineWidth',0.1,'Color',[128 128 128]/255)
plotm(lat,long,'-k','LineWidth',0.5)
scatterm(flipud(latitude),flipud(longtitude),10,flipud(rate_mean),'filled');
caxis([-5 5])
colormap(ax,MPL_BrBG)
h = colorbar('location','northoutside');
set(h,'position',[0.245 0.16 0.5 0.025],'xtick',-5:2.5:5,'xticklabel',{'<-5.0','-2.5','0','2.5','>5.0'},'FontSize',9);
h1 = text(-0.5,-1.5,'CLMT shift rate (m/yr)','FontSize',10);
set(h1,'Position',[-0.45,-0.92])
set(gcf, 'renderer', 'painters');

%% shift rate in boreal, temperate, tropical regions (Figure 4b)
clear all
elevation_removing = xlsread('G:\cp xinyue_code\2_treeline\rerunTC2010\new\ele1_removing_95percentile.xlsx');
latitude=elevation_removing(:,8);
boreal = find(latitude>50|latitude==50);
temperate = find(latitude<50&latitude>23.5  |latitude<-23.5);
tropic = find(latitude<=23.5&latitude>=-23.5);
for ii = 1:length(boreal)
    rate_b(ii,1) = elevation_removing(boreal(ii),4)/10;
     rate_b(ii,2) = elevation_removing(boreal(ii),7)/10;
end
for jj = 1:length(temperate)
    rate_temp(jj,1) = elevation_removing(temperate(jj),4)/10;
    rate_temp(jj,2) = elevation_removing(temperate(jj),7)/10;
end
for mm = 1:length(tropic)
    rate_tro(mm,1) = elevation_removing(tropic(mm),4)/10;
    rate_tro(mm,2) = elevation_removing(tropic(mm),7)/10;
end
rng('default')  % For reproducibility
x1 = rate_b(:,1);
x2 = rate_temp(:,1);
x3 = rate_tro(:,1);
x = [x1;x2;x3];
g1 = repmat({'Boreal'},length(boreal),1);
g2 = repmat({'Temperate'},length(temperate),1);
g3 = repmat({'Tropical'},length(tropic),1);
g = [g1; g2;g3];

figure
boxplot(x,g,'symbol','')
ylabel('CLMT shift rate (m/yr)')
ylim([-12 19.5])
hold on 
plot(1,nanmean(rate_b(:,1)),'.','MarkerSize',20,'MarkerEdgeColor','r')
hold on
plot(2,nanmean(rate_temp(:,1)),'.','MarkerSize',20,'MarkerEdgeColor','r') 
hold on
plot(3,nanmean(rate_tro(:,1)),'.','MarkerSize',20,'MarkerEdgeColor','r') 
hold on 
plot(1,max(rate_b(:,1)),'+','MarkerSize',8,'MarkerEdgeColor','r')
hold on
plot(2,max(rate_temp(:,1)),'+','MarkerSize',8,'MarkerEdgeColor','r') 
hold on
plot(3,max(rate_tro(:,1)),'+','MarkerSize',8,'MarkerEdgeColor','r') 
hold on 
plot(1,min(rate_b(:,1)),'+','MarkerSize',8,'MarkerEdgeColor','r')
hold on
plot(2,min(rate_temp(:,1)),'+','MarkerSize',8,'MarkerEdgeColor','r') 
hold on
plot(3,min(rate_tro(:,1)),'+','MarkerSize',8,'MarkerEdgeColor','r') 
text(0.9,18.2,'n = 804')
text(1.9,18.2,'n = 270')
text(2.9,18.2,'n = 36')
hold on 
line([0,4],[0,0],'linestyle','--','color','black');
