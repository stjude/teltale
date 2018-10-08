//------------------------------------------------------------------------------------
//
// teltale.cpp - program to compute the fraction of telomeric reads in a BAM file;
//               a read is considered telomeric if it contains at least
//               MIN_OCCURRENCES consecutive occurrences of the telomere motif;
//               reads marked as duplicate or failed QC are excluded from the
//               computation
//
// Author: Stephen V. Rice, Ph.D.
//
// Copyright 2017 St. Jude Children's Research Hospital
//
//------------------------------------------------------------------------------------

#include <cstdint>
#include <cstring>
#include <iostream>
#include <stdexcept>
#include <string>
#include "api/BamReader.h"

const std::string VERSION = "teltale 2.0";

const int MIN_OCCURRENCES = 7;
const int MOTIF_LENGTH    = 6;
const int TARGET_LENGTH   = MIN_OCCURRENCES * MOTIF_LENGTH;

const char *MOTIF_FORWARD = "TTAGGG";  // telomere motif
const char *MOTIF_REVERSE = "CCCTAA";  // reverse complement

char targetForward[TARGET_LENGTH + 1]; // sequence of telomere motifs
char targetReverse[TARGET_LENGTH + 1]; // sequence of reverse complements

uint64_t numReads = 0, numTelomericReads = 0; // counters

//------------------------------------------------------------------------------------
// setupTarget() initializes a target sequence

void setupTarget(char *target, const char *motif)
{
   for (int i = 0; i < MIN_OCCURRENCES; i++)
   {
      std::strcpy(target, motif);
      target += MOTIF_LENGTH;
   }
}

//------------------------------------------------------------------------------------
// setupTargets() initializes both target sequences

void setupTargets()
{
   setupTarget(targetForward, MOTIF_FORWARD);
   setupTarget(targetReverse, MOTIF_REVERSE);
}

//------------------------------------------------------------------------------------
// isTelomeric() returns true if either the forward or reverse target can be found
// within the read sequence

bool isTelomeric(const char *readSequence)
{
   return (std::strstr(readSequence, targetForward) ||
           std::strstr(readSequence, targetReverse));
}

//------------------------------------------------------------------------------------
// readBamFile() reads a BAM file and counts telomeric reads

void readBamFile(const std::string& filename)
{
   BamTools::BamReader bamReader;

   if (!bamReader.Open(filename))
      throw std::runtime_error("unable to open " + filename);

   BamTools::BamAlignment alignment;

   while (bamReader.GetNextAlignment(alignment))
      if (!alignment.IsFailedQC() && !alignment.IsDuplicate())
      {
         numReads++;

	 if (isTelomeric(alignment.QueryBases.c_str()))
            numTelomericReads++;
      }

   bamReader.Close();
}

//------------------------------------------------------------------------------------

int main(int argc, char *argv[])
{
   if (argc != 2 || argv[1][0] == '-')
   {
      std::cout << VERSION << std::endl << std::endl;

      std::cout << "Usage: " << argv[0]
		<< " bamfilename"
	       	<< std::endl;

      return 1;
   }

   try
   {
      setupTargets();

      std::string bamfilename = argv[1];
      readBamFile(bamfilename);

      double fraction = (numReads == 0 ? 0.0 :
                         numTelomericReads / static_cast<double>(numReads));

      std::cout << numReads
                << "\t" << numTelomericReads
		<< "\t" << fraction
		<< "\t" << bamfilename
		<< std::endl;
   }
   catch (const std::runtime_error& error)
   {
      std::cerr << argv[0] << ": " << error.what() << std::endl;
      return 1;
   }

   return 0;
}
