within Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Examples;
model ZenithAngle "Test model for zenith angle"
  import Buildings;
  Buildings.BoundaryConditions.SolarGeometry.BaseClasses.ZenithAngle zen(lat=0)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.BoundaryConditions.SolarGeometry.BaseClasses.Declination decAng
    "Declination angle"
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Buildings.BoundaryConditions.SolarGeometry.BaseClasses.SolarHourAngle
    solHouAng
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
equation
  connect(decAng.decAng, zen.decAng) annotation (Line(
      points={{41,30},{50,30},{50,5.4},{58,5.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(solHouAng.solHouAng, zen.solHouAng) annotation (Line(
      points={{41,-30},{50,-30},{50,-4.8},{58,-4.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-60,5.82867e-16},{-46,5.82867e-16},{-46,0},{-42,0},{-42,
          5.55112e-16},{-34,5.55112e-16}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.cloTim, decAng.nDay) annotation (Line(
      points={{-34,5.55112e-16},{-18,5.55112e-16},{-18,30},{18,30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.solTim, solHouAng.solTim) annotation (Line(
      points={{-34,5.55112e-16},{-18,5.55112e-16},{-18,-30},{18,-30}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Diagram(graphics), Commands(file="ZenithAngle.mos" "run"));
end ZenithAngle;
