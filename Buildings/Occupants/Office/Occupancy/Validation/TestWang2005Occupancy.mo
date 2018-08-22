within Buildings.Occupants.Office.Occupancy.Validation;
model TestWang2005Occupancy "Validation model for Wang2005Occupancy"
  extends Modelica.Icons.Example;

Wang2005Occupancy occ "Tested Occupancy model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));


annotation (
experiment(Tolerance=1e-6, StopTime=36000.0),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Occupants/Office/Occupancy/Validation/TestWang2005Occupancy.mos"
                      "Simulate and plot"),
Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Occupants.Office.Occupancy.Wang2005Occupancy\">
Buildings.Occupants.Office.Occupancy.Wang2005Occupancy</a>
by examing output of occupancy state.
</p>
</html>",
        revisions="<html>
<ul>
<li>
August 1, 2018, by Zhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"));
end TestWang2005Occupancy;