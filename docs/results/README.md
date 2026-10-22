# Physical Design Results

These artifacts are from the OpenLane v0.21 run
`21-10_12-40` for `adaptive_clock_gating_v3`.

## Main deliverables

- `adaptive_clock_gating_v3.gds`: primary GDS deliverable
- `adaptive_clock_gating_v3_magic.gds`: Magic-generated GDS variant
- `adaptive_clock_gating_v3_klayout.gds`: KLayout GDS variant
- `final_summary_report.csv`: OpenLane summary metrics
- `39-magic.drc`: Magic DRC report
- `manufacturability_report.rpt`: manufacturability report
- `post_resizer_timing_min_max.rpt`: post-resizer timing report

## Physical design data

The `physical_design/` directory contains selected floorplan,
placement, CTS, and routed DEF files, the SPEF parasitic file,
an LVS powered netlist, and additional GDS variants.

## Verification caveats

The run reported zero Magic DRC violations, zero TritonRoute
violations, zero antenna violations, and zero LVS summary errors.

These are the reported results from this OpenLane run, not
independent foundry signoff.

The available post-resizer report contains selected timing paths,
but complete post-route timing closure has not been established
by the available timing reports.
