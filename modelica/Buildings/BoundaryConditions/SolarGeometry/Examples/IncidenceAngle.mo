within Buildings.BoundaryConditions.SolarGeometry.Examples;
model IncidenceAngle "Test model for solar incidence angle"
  import Buildings;
  Buildings.BoundaryConditions.SolarGeometry.IncidenceAngle incAng(
    lat=0.73097781993588,
    azi=0.3,
    til=0.5) "The location is Chicago"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(weaDat.weaBus, incAng.weaBus) annotation (Line(
      points={{-40,10},{-20,10},{-20,10.4},{-5.55112e-16,10.4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  annotation (Diagram(graphics), Commands(file="IncidenceAngle.mos" "run"));
end IncidenceAngle;
