data factsheet; *A new dataset called 'hc' gets written to the work library with the newly created variables at the far right;
   set class.Mh2_qis_transposed; *library name and dataset name of the dataset you are starting with;

   /* rename variables */
   recentadmiss=dd1;
   agefirsthosp=dd6;
   admitsubs=cc2d;

   /* diagnoses - used in all figures, figures 3 & 7-10 only use dsmsubs */ 
   if q1a in (1, 2, 3) then dsmchild=1; else dsmchild=0;
   if q1b in (1, 2, 3) then dsmcogn=1; else dsmcogn=0;
   if q1c in (1, 2, 3) then dsmgeneral=1; else dsmgeneral=0;
   if q1d in (1, 2, 3) then dsmsubs=1; else dsmsubs=0;             
   if q1e in (1, 2, 3) then dsmpsych=1; else dsmpsych=0;
   if q1f in (1, 2, 3) then dsmmood=1; else dsmmood=0;
   if q1g in (1, 2, 3) then dsmanx=1; else dsmanx=0;
   if q1h in (1, 2, 3) then dsmsom=1; else dsmsom=0;
   if q1i in (1, 2, 3) then dsmfac=1; else dsmfac=0;
   if q1j in (1, 2, 3) then dsmdiss=1; else dsmdiss=0;
   if q1k in (1, 2, 3) then dsmsex=1; else dsmsex=0;
   if q1l in (1, 2, 3) then dsmeat=1; else dsmeat=0;
   if q1m in (1, 2, 3) then dsmsleep=1; else dsmsleep=0;
   if q1n in (1, 2, 3) then dsmimp=1; else dsmimp=0;
   if q1o in (1, 2, 3) then dsmadj=1; else dsmadj=0;
   if q1p in (1, 2, 3) then dsmper=1; else dsmper=0;
   if q1a in (1, 2, 3) or q1h in (1, 2, 3) or q1i in (1, 2, 3) or q1j in (1, 2, 3) or 
      q1k in (1, 2, 3) or q1l in (1, 2, 3) or q1m in (1, 2, 3) then other=1; else other=0;
   
   /* figure 2 - recent admissions */
   if recentadmiss=0 then ragrp="None";
   if recentadmiss=1 then ragrp="1-2 admissions";
   if recentadmiss=2 then ragrp="3+";

   /* figure 3- number of diagnoses */
   numdiagn = dsmchild+dsmcogn+dsmgeneral+dsmsubs+dsmpsych+dsmmood+dsmanx+dsmsom+dsmfac+
              dsmdiss+dsmsex+dsmeat+dsmsleep+dsmimp+dsmadj+dsmper ;
   
   if numdiagn eq 1 then diagngrp='1 diagnosis';
   if numdiagn in (2, 3) then diagngrp='2-3 diagnoses';

   /* figure 5 - self-injury */
   if dsmsubs=0 and dsmmood=1 then grp1="Mood, no SU";
   if dsmsubs=1 and dsmmood=0 then grp1="SU, no mood";

   if dsmsubs=1 and dsmmood=1 then grp2="Mood & SU"; 
   if dsmsubs=0 and dsmmood=1 then grp2="Mood, no SU";

   if dsmsubs=1 and dsmmood=1 then grp3="Mood & SU"; 
   if dsmsubs=1 and dsmmood=0 then grp3="SU, no mood";

   if d1a in (1,2,3,4) then selfinj1=1; else selfinj1=0;
   if d1b=1 then selfinj2=1; else selfinj2=0;
   if d1c=1 then selfinj3=1; else selfinj3=0;
   if d1d=1 then selfinj4=1; else selfinj4=0;
   selfinjscore=selfinj1+selfinj2+selfinj3+selfinj4;
   
    /* figure 6 - age grouping */
   /* if 0 le approx_age lt 15  then agegrp='a0-14  '; excluded due to n=4 */
   if 15 le approx_age lt 25 then agegrp='a15-24  '; 
   if 25 le approx_age lt 45 then agegrp='b25-44  '; 
   if 45 le approx_age lt 65 then agegrp='c45-64  ';
   if 65 le approx_age lt 115 then agegrp='d65+  ';  

   /* figure 7 - age 1st hospitalization */
   if 30 le approx_age lt 115 then older='c30+  ';  

   if agefirsthosp in (1, 2) then firsthosp='below 25';
   if agefirsthosp in (3, 4, 5) then firsthosp='25+';

   /* figure 8 - dropout, crime, family */
   if j1f in (1,2,3) then dropout='dropout'; else dropout='non-dropout';
   if o1 in (2, 3) then familydisrupt=1; else familydisrupt=0;

   if a5a in (1, 2, 3, 4) then crime=1;
   else if a5b in (1, 2, 3, 4) then crime=1;
   else crime=0;
   
    /* figure 9 - addictive behaviours */
   if admitsubs=1 or dsmsubs=1 then subuse=1;
   else subuse=0;

   if c1=3 then addictbehav=1;                 /*alcohol*/
   else if c2a in (4, 5) then addictbehav=1;
   else if c2b in (4, 5) then addictbehav=1;
   else if c2c in (4, 5) then addictbehav=1;
   else if c2d in (4, 5) then addictbehav=1;
   else if c2e in (4, 5) then addictbehav=1;
   else if c3 in (1, 2, 3) then addictbehav=1;
   else if c4a=1 then addictbehav=1;
   else if c4b=1 then addictbehav=1;
   else if c4c=1 then addictbehav=1;
   else if c4d=1 then addictbehav=1; 
   if (c1 in (0,1,2)) and (c2a in (0,1,2,3)) and (c2b in (0,1,2,3)) and 
      (c2c in (0,1,2,3)) and (c2d in (0,1,2,3)) and (c2e in (0,1,2,3)) and 
       c3=0 and c4a=0 and c4b=0 and c4c=0 and c4d=0 then addictbehav=0;

   if addictbehav=1 or c2f in (4, 5) then addictcan=1; else addictcan=0;   /*cannabis*/
   if addictcan=1 or c5 in (1, 2) then addictsmoke=1; else addictsmoke=0;  /*daily smoker */

   /* figure 10 - compliance with treatment */
   if l5 in (0, 1) then adheretx="Adheres 80%+"; 
   else if l5=2 then adheretx="Adheres <80%";

   if l3a=1 or l3b=1 or l3c=1 or l3d=1 then refuse="1+"; 
   else if (l3a gt 1) or (l3b gt 1) or (l3c gt 1) or (l3d gt 1) then refuse="None";

run;

ods rtf file='f:\commonoutput\hirdes class\Ashley\factsheetfinal.rtf';

proc freq;
title "Figure 1 - Diagnoses Percentage Across Dataset";
tables dsmcogn dsmgeneral dsmsubs dsmpsych dsmmood dsmanx dsmadj dsmper dsmimp other;
run;

proc freq;
title "Figure 2 - Re-admission within last 2 yrs amongst most common diagnoses";
tables (dsmsubs dsmcogn dsmpsych dsmmood dsmanx dsmper)*ragrp;
run;

proc freq;
title "Figure 3 - Number of diagnoses";
tables dsmsubs*diagngrp/chisq;
run;

proc freq;
title "Figure 4 - Most common disorders occuring with substance use disoder";
tables dsmsubs * (dsmcogn dsmgeneral dsmpsych dsmmood dsmanx dsmimp dsmadj dsmper other);
run;

proc freq;
title "Figure 5 - Self-injury relationship with Mood and/or substance use disorder";
tables (grp1 grp2 grp3) *selfinjscore/ chisq;
run;

proc freq;
title "Figure 6 - Distribution of top 3 disorders amongst age groups";
tables agegrp*dsmsubs agegrp*dsmmood agegrp*dsmpsych / chisq; 
run;

proc freq;
title "Figure 7 - Age of 1st Hospitalization";
tables older*dsmsubs*firsthosp / chisq; 
run;

proc freq;
title "Figure 8 - Substance use disorder and crime, family, school";
tables dsmsubs * (crime familydisrupt dropout) / chisq;
run;

proc freq;
title "Figure 9 - Recent addictive behaviours";
tables subuse * (addictbehav addictcan addictsmoke);
run;

proc freq;
title "Figure 10 - Adherence and refusal to treatment";
tables dsmsubs *(adheretx refuse) / chisq;
run;

ods rtf close;

