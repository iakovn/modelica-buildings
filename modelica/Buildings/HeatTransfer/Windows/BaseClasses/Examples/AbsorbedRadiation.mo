within Buildings.HeatTransfer.Windows.BaseClasses.Examples;
model AbsorbedRadiation "Test model for absorbed radiation by windows"
  import Buildings;
  parameter Modelica.SIunits.Angle lat=0.34906585039887 "Latitude";
  parameter Modelica.SIunits.Angle azi=0 "Surface azimuth";
  parameter Modelica.SIunits.Angle til=1.5707963267949 "Surface tilt";

  BoundaryConditions.SolarIrradiation.DirectTiltedSurface
    HDirTil(
    til=til,
    lat=lat,
    azi=azi)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-38,0},{-18,20}})));
  BoundaryConditions.WeatherData.Reader weaDat(filNam=
        "Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));

  BoundaryConditions.SolarIrradiation.DiffuseIsotropic
    HDifTilIso(til=til)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.Constant shaCon(k=if (glaSys.haveShade) then 0.5 else
              0)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Buildings.HeatTransfer.Windows.BaseClasses.AbsorbedRadiation winAbs(
    AWin=1,
    N=glaSys.nLay,
    tauGlaSW=glaSys.glass.tauSW,
    rhoGlaSW_a=glaSys.glass.rhoSW_a,
    rhoGlaSW_b=glaSys.glass.rhoSW_b,
    tauShaSW_a=glaSys.shade.tauSW_a,
    tauShaSW_b=glaSys.shade.tauSW_b,
    rhoShaSW_a=glaSys.shade.rhoSW_a,
    rhoShaSW_b=glaSys.shade.rhoSW_b,
    haveExteriorShade=glaSys.haveExteriorShade,
    haveInteriorShade=glaSys.haveInteriorShade)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
    shade=Buildings.HeatTransfer.Data.Shades.Gray(),
    UFra=2,
    haveExteriorShade=false,
    haveInteriorShade=true) "Parameters for glazing system"
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Modelica.Blocks.Sources.Constant HRoo(k=10)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
equation
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-50,10},{-28,10}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDirTil.weaBus, weaBus) annotation (Line(
      points={{20,10},{-28,10}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus, HDifTilIso.weaBus) annotation (Line(
      points={{-28,10},{6,10},{6,50},{20,50}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(shaCon.y,winAbs. uSha) annotation (Line(
      points={{81,-30},{90,-30},{90,-10},{69.8,-10},{69.8,-1.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(winAbs.HDir, HDirTil.H) annotation (Line(
      points={{58.5,14},{46,14},{46,10},{41,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDifTilIso.H,winAbs. HDif) annotation (Line(
      points={{41,50},{48,50},{48,18},{58.5,18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HDirTil.inc,winAbs. incAng) annotation (Line(
      points={{41,6},{46,6},{46,9},{58.5,9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HRoo.y,winAbs. HRoo) annotation (Line(
      points={{41,-30},{50,-30},{50,2.4},{58.5,2.4}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    Commands(file="AbsorbedRadiation.mos" "run"),
    Documentation(info="<html>
This example illustrates modeling of window radiation.
</html>", revisions="<html>
<ul>
<li>
December 15, 2010, by Wangda Zuo:<br>
First implementation.
</li>
</ul>
</html>"));
end AbsorbedRadiation;
