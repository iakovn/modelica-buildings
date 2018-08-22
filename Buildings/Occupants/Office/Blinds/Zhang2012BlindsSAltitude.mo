﻿within Buildings.Occupants.Office.Blinds;
model Zhang2012BlindsSAltitude
  "A model to predict occupants' blinds behavior with Solar Altitude"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Real Aup = 0.019 "Slope of Solar Altitude for blinds up";
  parameter Real Adown = 0.018 "Slope of Solar Altitude for blinds down";
  parameter Real Bup = -3.446 "Intercept for blinds up";
  parameter Real Bdown = -3.424 "Intercept for blinds down";
  parameter Integer seed = 10 "Seed for the random number generator";
  parameter Modelica.SIunits.Time samplePeriod = 120 "Sample period";

  Modelica.Blocks.Interfaces.RealInput SA(
    unit="deg") "Solar Altitude" annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.BooleanInput occ
    "Indoor occupancy, true for occupied"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealOutput BlindState
    "The State of Blinds, 1 for 100% on, 0 for 100% off"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Real pup(
    unit="1",
    min=0,
    max=1) "The probability of blinds up";
  Real pdown(
    unit="1",
    min=0,
    max=1) "The probability of blinds down";

protected
  parameter Modelica.SIunits.Time t0(fixed = false) "First sample time instant";
  output Boolean sampleTrigger "True, if sample time instant";

initial equation
  t0 = time;
  BlindState = 1 "Initial state of blinds is 100% on";

equation
  sampleTrigger = sample(t0,samplePeriod);
  when sampleTrigger then
    pup = Modelica.Math.exp(Aup*SA+Bup)/(Modelica.Math.exp(Aup*SA+Bup)+1);
    pdown = Modelica.Math.exp(Adown*SA+Bdown)/(Modelica.Math.exp(Adown*SA+Bdown)+1);
    if occ then
      if pre(BlindState) == 1 then
        if Buildings.Occupants.BaseClasses.binaryVariableGeneration(p=pdown,globalSeed=seed) then
          BlindState = 0;
        else
          BlindState = 1;
        end if;
      else
        if Buildings.Occupants.BaseClasses.binaryVariableGeneration(p=pup,globalSeed=seed) then
          BlindState = 1;
        else
          BlindState = 0;
        end if;
      end if;
    else
      BlindState = 1;
    end if;
  end when;

  annotation (graphics={
            Rectangle(extent={{-60,40},{60,-40}}, lineColor={28,108,200}), Text(
            extent={{-40,20},{40,-20}},
            lineColor={28,108,200},
            fillColor={0,0,255},
            fillPattern=FillPattern.Solid,
            textStyle={TextStyle.Bold},
            textString="Blinds_SA")},
defaultComponentName="bli",
Documentation(info="<html>
<p>
Model predicting the state of the blinds with the solar altitude 
and occupancy.
</p>
<h4>Inputs</h4>
<p>
SA: solar altitude, should be input with the unit of degree.
</p>
<p>
Occupancy: a boolean variable, true indicates the space is occupied, 
false indicates the space is unoccupied.
</p>
<h4>Outputs</h4>
<p>The state of blinds: a real variable, 1 indicates the blind 
is 100% on, 0 indicates the blind is 100% off.
</p>
<h4>Dynamics</h4>
<p>
When the space is unoccupied, the blinds is always on. When the 
space is occupied, the lower the SA is, the higher 
the chance that the blind state will be changed, either being turned on or turned off.
</p>
<h4>References</h4>
<p>
The model is documented in the paper &quot;Zhang, Y. and Barrett, P., 2012. 
Factors influencing occupants’ blind-control behaviour in a naturally 
ventilated office building. Building and Environment, 54, pp.137-147.&quot;.
</p>
<p>
The model parameters are regressed from the field study in an office building
in Sheffield, England.
</p>
</html>",
revisions="<html>
<ul>
<li>
July 24, 2018, by Zhe Wang:<br/>
First implementation.
</li>
</ul>
</html>"));
end Zhang2012BlindsSAltitude;