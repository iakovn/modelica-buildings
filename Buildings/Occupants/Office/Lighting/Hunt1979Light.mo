within Buildings.Occupants.Office.Lighting;
model Hunt1979Light "A model to predict occupants' lighting behavior with illuminance"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Real AArriv = -0.0175 "upon arrival";
  parameter Real BArriv = -4.0835 "upon arrival";
  parameter Real CArriv = 1.0361 "upon arrival";
  parameter Real MArriv = 1.8223 "upon arrival";
  parameter Integer seed = 30 "Seed for the random number generator";
  parameter Modelica.SIunits.Time samplePeriod = 120 "Sample period";

  Modelica.Blocks.Interfaces.RealInput Illu "Minimum illuminance on the working plane, unit:lux" annotation (
       Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput occ
    "Indoor occupancy, true for occupied"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.BooleanOutput on "State of Lighting"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Real pArriv(
    unit="1",
    min=0,
    max=1) "Probability of switch on the lighting upon arrival";

protected
  parameter Modelica.SIunits.Time t0(fixed = false) "First sample time instant";
  output Boolean sampleTrigger "True, if sample time instant";
initial equation
  t0 = time;
  on = false;
equation
  if Illu > 657.7 then
    pArriv =0;
  elseif Illu < 7.0 then
    pArriv =1;
  else
    pArriv =AArriv + CArriv/(1 + Modelica.Math.exp(-BArriv*(
      Modelica.Math.log10(Illu) - MArriv)));
  end if;
  sampleTrigger = sample(t0, samplePeriod);
  when {occ,sampleTrigger} then
    if sampleTrigger then
      if occ then
        on = pre(on);
      else
        on = false;
      end if;
    else
      on = Buildings.Occupants.BaseClasses.binaryVariableGeneration(p=pArriv, globalSeed=seed);
    end if;
  end when;
  annotation (graphics={
            Rectangle(extent={{-60,40},{60,-40}}, lineColor={28,108,200}), Text(
            extent={{-40,20},{40,-20}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textStyle={TextStyle.Bold},
            textString="Light_Illu")},
defaultComponentName="lig",
Documentation(info="<html>
<p>
Model predicting the state of the lighting with the minimum illuminance on the working plane
and occupancy.
</p>
<h4>Inputs</h4>
<p>
illuminance: the minimum illuminance on the working plane, should be input with the unit of lux.
</p>
<p>
Occupancy: a boolean variable, true indicates the space is occupied, 
false indicates the space is unoccupied.
</p>
<h4>Outputs</h4>
<p>The state of lighting: a boolean variable, true indicates the light 
is on, false indicates the light is off.
</p>
<h4>Dynamics</h4>
<p>
In this model, it was found people tend to switch on the lights-if needed- only at times when 
entering a space, and they rarely switch off the lights until the space becomes completely empty.
</p>
<p>
The Probability to switch on the lights upon arrival would depend on the minimum illuminance level 
on their working plane.
</p>
<h4>References</h4>
<p>
The model is documented in the paper &quot;Hunt, D.R.G., 1980. Predicting artificial 
lighting use-a method based upon observed patterns of behaviour. Lighting Research & Technology, 
12(1), pp.7-14.&quot;.
</p>
<p>
The model parameters are regressed from the field study in 10 offices in Germany from
Mar. to Dec. 2000.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 26, 2018, by Zhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"));
end Hunt1979Light;