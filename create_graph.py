import subprocess
import time

# TODO: env var / cmd line option
path = 'file:///c:/git/mortality/data/2015_data.csv'

dimensions =  [
 "resident_status",
 "education_1989_revision",
 "education_2003_revision",
 "education_reporting_flag",
 "month_of_death",
 "sex",
 "age_substitution_flag",
 "age_recode_52",
 "age_recode_27",
 "age_recode_12",
 "infant_age_recode_22",
 "place_of_death_and_decedents_status",
 "marital_status",
 "day_of_week_of_death",
 "current_data_year",
 "injury_at_work",
 "manner_of_death",
 "method_of_disposition",
 "autopsy",
 "activity_code",
 "place_of_injury_for_causes_w00_y34_except_y06_and_y07_",
 "358_cause_recode",
 "113_cause_recode",
 "130_infant_cause_recode",
 "39_cause_recode",
 "race",
 "bridged_race_flag",
 "race_imputation_flag",
 "race_recode_3",
 "race_recode_5",
 "hispanic_origin",
 "hispanic_originrace_recode",
 "detail_age_type"
]

start_time = time.time()

# TODO: create links for ICD and other fields to ICD Code/Category nodes
# "icd_code_10th_revision",

# Create dimension nodes, equiv of:
# > cat <path>/create_dimensions.cql | cypher-shell.bat --format verbose
p1 = subprocess.Popen(['cat', './cypher/create_dimensions.cql'], stdout=subprocess.PIPE)
p2 = subprocess.Popen(['cypher-shell.bat', '--format', 'plain'], stdin=p1.stdout, stdout=subprocess.PIPE)
print (p2.communicate())

#
# Loop through data, creating nodes and linking them to dimension nodes
#

# Load the template
with open('cypher/dimension_mapper_template.cql') as template_file:
    template = template_file.read().decode('utf8')

# For each dimension, run the template cypher with dimensions substituted
for dim in dimensions:
	start_dim = time.time()
	print 
	print "Mapping dimension " + dim
	print "--------------------------------------------"
	if dim[0].isdigit():
		label = '_' + dim
	else:
		label = dim.capitalize()

	cypher = template.replace('%%path%%', path) \
	                 .replace('%%dimension%%', dim) \
	                 .replace('%%label%%', label) \
	                 .replace('%%relation%%', 'HAS_' + dim.upper())

	p1 = subprocess.Popen(['echo', cypher], stdout=subprocess.PIPE)
	p2 = subprocess.Popen(['cypher-shell.bat', '--format', 'plain'], stdin=p1.stdout, stdout=subprocess.PIPE)
	print (p2.communicate())

	seconds = time.time() - start_dim
	print
	print "took " + str(seconds) + " seconds."
	print "------------------------------------"

seconds = time.time() - start_time
minutes = seconds // 60
seconds = seconds % 60
print
print "------------------------------------"
print "Script took " + str(minutes) + ":" + str(seconds)
print "------------------------------------"

