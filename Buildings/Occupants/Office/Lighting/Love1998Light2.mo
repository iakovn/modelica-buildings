within Buildings.Occupants.Office.Lighting;
model Love1998Light2 "A model to predict occupants' lighting behavior with illuminance"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Real B = 7.19 "Intercept for logistic regression";
  parameter Real M = -17.06 "Slope for logistic regression";
  parameter Integer seed = 30 "Seed for the random number generator";
  parameter Modelica.SIunits.Time samplePeriod = 120 "Sample period";

  Modelica.Blocks.Interfaces.RealInput Illu "Daylight illuminance level on the desk, unit:lux" annotation (
       Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput occ
    "Indoor occupancy, true for occupied"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.BooleanOutput on "State of Lighting"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Real p(
    unit="1",
    min=0,
    max=1) "Probability of switch on the lighting";

protected
  parameter Modelica.SIunits.Time t0(fixed = false) "First sample time instant";
  output Boolean sampleTrigger "True, if sample time instant";
initial equation
  t0 = time;
  on = false;
equation
  p = Modelica.Math.exp(B+M*Modelica.Math.log10(Illu))/(1 - Modelica.Math.exp(B+M*Modelica.Math.log10(Illu)));
  sampleTrigger = sample(t0, samplePeriod);
  when {occ,sampleTrigger} then
    if sampleTrigger then
      if occ then
        on = pre(on);
      else
        on = false;
      end if;
    else
      on = Buildings.Occupants.BaseClasses.binaryVariableGeneration(p=p, globalSeed=seed);
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
Model predicting the state of the lighting with the daylight illuminance level on the desk
and occupancy.
</p>
<h4>Inputs</h4>
<p>
illuminance: Daylight illuminance level on the desk, should be input with the unit of lux.
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
In this model, the switching on action only happens upon arrival.
</p>
<p>
The Probability to switch on the lights upon arrival would depend on the daylight illuminance 
level on the desk.
</p>
<h4>References</h4>
<p>
The model is documented in the paper &quot;Love, J.A., 1998. Manual switching patterns in 
private offices. International journal of lighting research and technology, 30(1), pp.45-50.&quot;.
</p>
<p>
The model parameters are regressed from observing the behavior of a 50 years old female with
spectacles, who was located in a private office in Calgary, Canada.
</p>
<p>
The parameters recorded in the paper seem to be problematic and unable to reproduce the probability
function illustrated in the paper.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 27, 2018, by Zhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"));
end Love1998Light2;