rpclink = hre.network.config.url;
  const [encryptedData, usedEncryptedKey] = await encryptDataField(rpclink, data);
  const response = await provider.call({
    to: destination,
    data: encryptedData,
  });
  return await decryptNodeResponse(rpclink, response, usedEncryptedKey);
};

async function main() {
  const contractAddress = "0xf84Df872D385997aBc28E3f07A2E3cd707c9698a";
  const [signer] = await hre.ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("Swisstronik");
  const contract = contractFactory.attach(contractAddress);
  const functionName = "getMessage";
  const responseMessage = await sendShieldedQuery(signer.provider, contractAddress, contract.interface.encodeFunctionData(functionName));
  console.log("Decoded response:", contract.interface.decodeFunctionResult(functionName, responseMessage)[0]);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
EOL
echo "getMessage.js script created."

# Run getMessage.js script
echo "Running getMessage.js..."
npx hardhat run scripts/getMessage.js --network swisstronik
echo "Message retrieved."

echo "Done! Subscribe: https://t.me/feature_earning"
