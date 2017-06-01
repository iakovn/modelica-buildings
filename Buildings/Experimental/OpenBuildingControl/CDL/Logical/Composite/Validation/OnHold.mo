within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Composite.Validation;
model OnHold "Validation model for the OnHold block"
  import Buildings;

extends Modelica.Icons.Example;

  Sources.BooleanPulse                                                booPul(startTime=
       200, period=8000)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Logical.Composite.OnHold
    onHold annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(booPul.y, onHold.u)
    annotation (Line(points={{-19,0},{0,0},{19,0}}, color={255,0,255}));
  annotation (
  experiment(StopTime=15000.0, Tolerance=1e-06),
  __Dymola_Commands(
  file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/CDL/Logical/Composite/Validation/OnHold.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.CDL.Logical.Composite.OnHold\">
Buildings.Experimental.OpenBuildingControl.CDL.Logical.Composite.OnHold</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
May 24, 2017, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>

</html>"));
end OnHold;
