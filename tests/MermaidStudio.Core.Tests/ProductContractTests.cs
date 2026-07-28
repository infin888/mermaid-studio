using MermaidStudio.Core;

namespace MermaidStudio.Core.Tests;

public sealed class ProductContractTests
{
    [Fact]
    public void PinsTheCompatibilityBoundary()
    {
        Assert.Equal("Mermaid Studio", ProductContract.ProductName);
        Assert.Equal("11.16.0", ProductContract.MermaidVersion);
        Assert.Equal("1.0", ProductContract.AdapterProtocolVersion);
        Assert.Equal(34, ProductContract.CanonicalDiagramTypeCount);
    }
}
