#!/bin/bash

# Bash Script to Analyze Network Traffic

# Input: Path to the Wireshark pcap file


# Function to extract information from the pcap file
analyze_traffic() {
    pcap_file=$1

    
    # Use tshark or similar commands for packet analysis.

    total_Packets=`tshark -r ${pcap_file} | wc -l  `
    http_packet=`tshark -r ${pcap_file} -Y http | wc -l`
    tls_packet=`tshark -r ${pcap_file} -Y tls | wc -l`
    top_src_ip=$(tshark -r ${pcap_file} -T fields -e ip.src | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | sort | uniq -c | sort -nr | head -n 5)
    top_dst_ip=$(tshark -r ${pcap_file} -T fields -e ip.dst | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | sort | uniq -c | sort -nr | head -n 5)
    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    # Provide summary information based on your analysis
    echo "1. Total Packets: ${total_Packets}"
    echo "2. Protocols:"
    echo "   - HTTP: ${http_packet} packets"
    echo "   - HTTPS/TLS: ${tls_packet} packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Provide the top source IP addresses
    IFS=''
    echo "packets  ip"
    echo ${top_src_ip} 
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Provide the top destination IP addresse
    echo "packets  ip"
    echo ${top_dst_ip}
    echo ""
    echo "----- End of Report -----"
}

# Run the analysis function
main(){
    if [ -z $1 ]; then
        echo "please enter pcap"
        
    else
        analyze_traffic $1

    fi
}

main $1
